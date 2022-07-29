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
GH                := gh
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

PAAS_CF_REPO      := https://raw.githubusercontent.com/alphagov/paas-cf
PAAS_ENVDIR       := ~/.govuk-paas
DUBLIN_DOMAIN     := cloud.service.gov.uk
LONDON_DOMAIN     := london.cloud.service.gov.uk
CF1               := CF_HOME=$(PAAS_ENVDIR)/dublin $(CF)
CF2               := CF_HOME=$(PAAS_ENVDIR)/london $(CF)
LOGIN1            := https://login.$(DUBLIN_DOMAIN)/passcode
LOGIN2            := https://login.$(LONDON_DOMAIN)/passcode
CSV_FILES         := organizations.csv routes.csv virtual_machines.csv
CSV_FILES1        := apps.csv buildpacks.csv domains.csv feature_flags.csv isolation_segments.csv organization_quotas.csv processes.csv security_groups.csv service_brokers.csv service_instances.csv service_offerings.csv service_plans.csv service_route_bindings.csv spaces.csv space_quotas.csv stacks.csv users.csv
STEAMPIPE_PLUGINS := aws config csv docker github kubernetes net prometheus terraform zendesk

define api2csv
$(CF1) curl '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-dublin.csv
$(CF2) curl '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-london.csv
$(CSVSTACK) -g dublin,london -n region $1-dublin.csv $1-london.csv > $@
$(RM) $1-dublin.csv $1-london.csv 
endef

hack:
	@echo hack $(KEEP)
ifeq ($(KEEP),)
	@echo I would have deleted the files 
endif

status: README.md
	@$(GLOW) $<
	@$(GH) issue list

kanban:
	$(OPEN) https://github.com/pauldougan/paas-steampipe-dashboard/projects/1

all: login extract-data dashboard

clean:
	@echo clean platform data
	$(RM) $(CSV_FILES) $(CSV_FILES1)
	$(RM) *-dublin.csv
	$(RM) *-london.csv

dashboard:
	$(STEAMPIPE) dashboard --workspace-chdir paas-dashboard

data:
	$(VISIDATA) *.csv

extract-data: $(CSV_FILES1) $(CSV_FILES)

login:
	# TODO if already logged in dont do anything
	open $(LOGIN1)
	$(CF1) api https://api.cloud.service.gov.uk
	$(CF1) login --sso 

	open $(LOGIN2)
	$(CF2) api https://api.london.cloud.service.gov.uk
	$(CF2) login --sso 

	open $(LOGIN2)
	$(CF2) api https://api.london.cloud.service.gov.uk
	$(CF2) login --sso 

	$(CF1) api
	$(CF2) api


logout:
	$(CF1) logout
	$(CF2) logout


$(CSV_FILES1):
	$(call api2csv,$(basename $@))
	
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

virtual_machines.csv:
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,dublin,/' | $(SORT) | $(HEADER) -a environment,region,vm_type,vm_count > $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,london,/' | $(SORT) >> $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/stg-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/staging,london,/' | $(SORT) >> $@ 
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/isolation-segments/prod/govuk-notify-production.yml | $(GREP) number_of_cells | $(SED) -E -e 's/number_of_cells//' -e 's/: /,/' -e 's/^/production,dublin,isolation-segment/' | $(SORT) >> $@ 

start:
	$(STEAMPIPE service start)

query:
	$(STEAMPIPE) query

dependencies:
	mkdir -p $(PAAS_ENVDIR)/dublin             
	mkdir -p $(PAAS_ENVDIR)/london
	pip3 install -r requirements.txt           # python dependencies
	type cf || brew install cf-cli@8           # Cloud Foundry CLI
	type gawk || brew install gawk             # GNU awk	
	type gh || brew install gh                 # github cli
	type glow || brew install glow             # glow cli for handling markdown
	type gsed || brew install gnu-sed          # GNU sed
	type jq || brew install jq.                # JSON wrangling tool
	type steampipe || brew install steampipe   # make cloud apis queryable via SQL 
	type yq || brew install yq                 # YAML tools
	$(STEAMPIPE) plugin install $(STEAMPIPE_PLUGINS) 

issues:
	$(GH) issue list
