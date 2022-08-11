SHELL             := /usr/local/bin/bash
AWK               := gawk
CF                := cf
CSVCUT            := csvcut
CSVFORMAT         := csvformat 
CSVGREP           := csvgrep
CSVJSON           := csvjson
CSVSORT           := csvsort
CSVSQL            := csvsql
CSVSTACK          := csvstack
CSVTOTABLE        := csvtotable
CURL              := curl -s
DRAWIO            := /Applications/draw.io.app/Contents/MacOS/draw.io
GH                := gh
GIT               := git
GLOW              := glow
GREP              := grep 
HEADER            := ./bin/header
IN2CSV            := in2csv 
JQ                := jq
OPEN              := open
RM                := rm -rfv
SED               := gsed
SORT              := sort
STEAMPIPE         := steampipe
TEE               := tee
VISIDATA          := vd

CF_ORG            := admin
CF_SPACE          := billing
PAAS_CF_REPO      := https://raw.githubusercontent.com/alphagov/paas-cf
PAAS_ENVDIR       := ~/.govuk-paas
DUBLIN_DOMAIN     := cloud.service.gov.uk
LONDON_DOMAIN     := london.cloud.service.gov.uk
CF1               := CF_HOME=$(PAAS_ENVDIR)/dublin $(CF)
CF2               := CF_HOME=$(PAAS_ENVDIR)/london $(CF)
LOGIN1            := https://login.$(DUBLIN_DOMAIN)/passcode
LOGIN2            := https://login.$(LONDON_DOMAIN)/passcode
CSV_FILES         := aws_accounts.csv organizations.csv routes.csv virtual_machines.csv
CSV_FILES1        := apps.csv buildpacks.csv domains.csv feature_flags.csv isolation_segments.csv organization_quotas.csv processes.csv security_groups.csv service_brokers.csv service_instances.csv service_offerings.csv service_plans.csv service_route_bindings.csv spaces.csv space_quotas.csv stacks.csv users.csv
STEAMPIPE_PLUGINS := config csv github net rss prometheus terraform zendesk

define api2csv
$(CF1) curl '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-dublin.csv
$(CF2) curl '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-london.csv
$(CSVSTACK) -g dublin,london -n region $1-dublin.csv $1-london.csv > $@
$(RM) $1-dublin.csv $1-london.csv 
endef

status: README.md
	@$(GLOW) $<
	@$(GH) issue list


all: login extract-data dashboard

clean:
	@echo clean platform data
	$(RM) $(CSV_FILES) $(CSV_FILES1)
	$(RM) *-dublin.csv
	$(RM) *-london.csv

extract-data: $(CSV_FILES1) $(CSV_FILES)

login:
	# TODO if already logged in dont do anything
	open $(LOGIN1)
	$(CF1) api https://api.cloud.service.gov.uk
	$(CF1) login --sso -o $(CF_ORG) -s $(CF_SPACE)
	open $(LOGIN2)
	$(CF2) api https://api.london.cloud.service.gov.uk
	$(CF2) login --sso -o $(CF_ORG) -s $(CF_SPACE)
	open $(LOGIN2)
	$(CF2) api https://api.london.cloud.service.gov.uk
	$(CF2) login --sso -o $(CF_ORG) -s $(CF_SPACE)
	$(CF1) api
	$(CF2) api

logout:
	$(CF1) logout
	$(CF2) logout

$(CSV_FILES1):
	$(call api2csv,$(basename $@))

docs/datamodel.svg: docs/datamodel.drawio
	$(DRAWIO) -x -e  -o $@ $<

docs/datamodel.png: docs/datamodel.drawio
	$(DRAWIO) -x -e  -o $@ $<

aws_accounts.csv:
	(echo "---";\
	echo "accounts:";\
	for e in `gds aws | grep paas | gsed -E -e 's/^[ \t]+//' -e 's/ +[a-zA-Z0-9_ /t]+//' | sort`;\
	do \
  		echo "  -";\
  		gds aws $$e -d --skip-ip-range-checks | gsed -E 's/^/    /';\
	done) | yq -o json | in2csv -f json -k accounts > $@

organizations.csv:
	$(CF1) curl '/v3/organizations?per_page=5000' |\
	  $(JQ) --arg region dublin -r '.resources[] | [.metadata.annotations.owner, $$region, .name, .guid, .relationships.quota.data.guid, .created_at, .suspended] | @csv' |\
	  $(HEADER) -a "owner,region,org_name,org_guid,quota_guid,created,suspended" |\
	  $(CSVSORT) -c1,3 |\
	  $(SED) -E '/,CAT/d;/,BACC/d;/,ACC/d;/,SMOKE/d;/,ASATS/d' > organizations-dublin.csv
	$(CF2) curl '/v3/organizations?per_page=5000' |\
	  $(JQ) --arg region london -r '.resources[] | [.metadata.annotations.owner, $$region, .name, .guid, .relationships.quota.data.guid, .created_at, .suspended] | @csv' |\
	  $(HEADER) -a "owner,region,org_name,org_guid,quota_guid,created,suspended" |\
	  $(CSVSORT) -c1,3 |\
	  $(SED) -E '/,CAT/d;/,BACC/d;/,ACC/d;/,SMOKE/d;/,ASATS/d' > organizations-london.csv
	$(CSVSTACK) organizations-dublin.csv organizations-london.csv |\
		$(AWK) -F, -e '$$1 == ""  {print "UNDEFINED" $$0}; $$1 != "" {print $$0}' |\
    	$(CSVSORT) -c1,2 |\
      	$(CSVFORMAT) -U 1 > $@
	$(RM) organizations-dublin.csv organizations-london.csv
		
routes.csv:
	$(CF1) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-dublin.csv
	$(CF2) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-london.csv
	$(CF2) curl '/v3/routes?page=2&per_page=5000' | $(IN2CSV) -f json -k resources | $(SED) 1d >> routes-london.csv
	$(CSVSTACK) -g dublin,london -n region routes-dublin.csv routes-london.csv > $@
	$(RM) routes-dublin.csv routes-london.csv 

schemata.csv: 
	(for f in *.csv;\
	do \
	  csvcut $$f -n | gsed -E -e "s/^ +/$$f,/" -e "s/: +/,/";\
	done) |  bin/header -a 'file,seq,field' > $@

virtual_machines.csv:
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,dublin,/' | $(SORT) | $(HEADER) -a environment,region,vm_type,vm_count > $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,london,/' | $(SORT) >> $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/stg-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/staging,london,/' | $(SORT) >> $@ 
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/isolation-segments/prod/govuk-notify-production.yml | $(GREP) number_of_cells | $(SED) -E -e 's/number_of_cells//' -e 's/: /,/' -e 's/^/production,dublin,isolation-segment/' | $(SORT) >> $@ 

dependencies:
	mkdir -p $(PAAS_ENVDIR)/dublin             
	mkdir -p $(PAAS_ENVDIR)/london
	pip3 install -r requirements.txt                 # python dependencies
	type cf || brew install cf-cli@8                 # Cloud Foundry CLI
	type gds || brew install alphagov/gds/gds-cli    # GDS CLI (needs ssh config)
	brew install drawio                              # drawio diagram editor
	type gawk || brew install gawk                   # GNU awk	
	type gh || brew install gh                       # github cli
	type glow || brew install glow                   # glow cli for handling markdown
	type gsed || brew install gnu-sed                # GNU sed
	type jq || brew install jq.                      # JSON wrangling tool
	type steampipe || brew install steampipe         # make cloud apis queryable via SQL 
	type yq || brew install yq                       # YAML wrangling tool
	$(STEAMPIPE) plugin install $(STEAMPIPE_PLUGINS) # install plugins

dashboard:       ; @echo "http://localhost:9194/paas-dashboard.dashboard.paas";  $(STEAMPIPE) dashboard --browser=false --workspace-chdir dashboards ; 
edit-csv:        ;$(VISIDATA) *.csv
edit-model:      docs/datamodel.drawio ; $(DRAWIO) $<
issues:          ;$(GH) issue list
kanban:          ;$(OPEN) https://github.com/pauldougan/paas-steampipe-dashboard/projects/1
open:            ;$(OPEN) http://localhost:9194
publish-model:   docs/datamodel.svg docs/datamodel.png
	$(GIT) add 
query:           ;$(STEAMPIPE) query	start: ;$(STEAMPIPE service start)
