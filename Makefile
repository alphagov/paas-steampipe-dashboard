SHELL            := /usr/local/bin/bash
PAAS_CF_REPO     := https://raw.githubusercontent.com/alphagov/paas-cf
AWK              := gawk
CF               := cf
CSVCUT           := csvcut
CSVFORMAT        := csvformat 
CSVGREP          := csvgrep
CSVJSON          := csvjson
CSVSORT          := csvsort
CSVSQL           := csvsql
CSVSTACK         := csvstack
CSVTOTABLE       := csvtotable
CURL             := curl -s
GH               := gh
GLOW             := glow
GREP             := grep 
HEADER           := ./bin/header
IN2CSV           := in2csv 
JQ               := jq
OPEN             := open
RM               := rm -rfv
SED              := gsed
SORT             := sort
STEAMPIPE        := steampipe
TEE              := tee
VISIDATA         := vd

PAAS_ENVDIR   := ~/.govuk-paas
DUBLIN_DOMAIN := cloud.service.gov.uk
LONDON_DOMAIN := london.cloud.service.gov.uk
CF1           := CF_HOME=$(PAAS_ENVDIR)/dublin $(CF)
CF2           := CF_HOME=$(PAAS_ENVDIR)/london $(CF)
LOGIN1        := https://login.$(DUBLIN_DOMAIN)/passcode
LOGIN2        := https://login.$(LONDON_DOMAIN)/passcode
CSV_FILES     := apps.csv buildpacks.csv domains.csv feature_flags.csv isolation_segments.csv orgs.csv processes.csv routes.csv security_groups.csv service_plans.csv services.csv spaces.csv stacks.csv users.csv virtual_machines.csv

status: README.md
	@$(GLOW) $<
	@$(GH) issue list

kanban:
	$(OPEN) https://github.com/pauldougan/paas-steampipe-dashboard/projects/1

virtual_machines.csv:
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,dublin,/' | $(SORT) | $(HEADER) -a environment,region,vm_type,vm_count > $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,london,/' | $(SORT) >> $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/stg-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/staging,london,/' | $(SORT) >> $@ 
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/isolation-segments/prod/govuk-notify-production.yml | $(GREP) number_of_cells | $(SED) -E -e 's/number_of_cells//' -e 's/: /,/' -e 's/^/production,dublin,isolation-segment/' | $(SORT) >> $@ 

all: login extract-data dashboard

clean:
	@echo clean platform data
	$(RM) $(CSV_FILES)

dashboard:
	$(STEAMPIPE) dashboard --workspace-chdir paas-dashboard

data:
	$(VISIDATA) .

extract-data: $(CSV_FILES)

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

apps.csv:
	$(CF1) curl '/v3/apps?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > apps-dublin.csv
	$(CF2) curl '/v3/apps?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > apps-london.csv
	$(CSVSTACK) -g dublin,london -n region apps-dublin.csv apps-london.csv > $@
	$(RM) apps-dublin.csv apps-london.csv 

buildpacks.csv:
	$(CF1) curl '/v3/buildpacks?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $@

domains.csv:
	$(CF1) curl '/v3/domains?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > domains-dublin.csv
	$(CF2) curl '/v3/domains?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > domains-london.csv
	$(CSVSTACK) -g dublin,london -n region domains-dublin.csv domains-london.csv > $@
	$(RM) domains-dublin.csv domains-london.csv 

feature_flags.csv:
	$(CF1) curl '/v3/feature_flags?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > feature_flags-dublin.csv
	$(CF2) curl '/v3/feature_flags?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > feature_flags-london.csv
	$(CSVSTACK) -g dublin,london -n region feature_flags-dublin.csv feature_flags-london.csv > $@
	$(RM) feature_flags-dublin.csv feature_flags-london.csv 

isolation_segments.csv:
	$(CF1) curl '/v3/isolation_segments?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > isolation_segments-dublin.csv
	$(CF2) curl '/v3/isolation_segments?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > isolation_segments-london.csv
	$(CSVSTACK) -g dublin,london -n region isolation_segments-dublin.csv isolation_segments-london.csv > $@
	$(RM) isolation_segments-dublin.csv isolation_segments-london.csv 

orgs.csv: orgs-dublin.csv orgs-london.csv
	$(CSVSTACK) orgs-dublin.csv orgs-london.csv |\
		$(AWK) -F, -e '$$1 == ""  {print "UNDEFINED" $$0}; $$1 != "" {print $$0}' |\
    	$(CSVSORT) -c1,2 |\
      	$(CSVFORMAT) -U 1 > $@
	$(RM) orgs-dublin.csv orgs-london.csv
		
orgs-dublin.csv:
	$(CF1) curl '/v3/organizations?per_page=5000' |\
	  $(JQ) --arg region dublin -r '.resources[] | [.metadata.annotations.owner, $$region, .name, .guid, .created_at, .suspended] | @csv' |\
	  $(HEADER) -a "owner,region,org_name,org_guid,created,suspended" |\
	  $(CSVSORT) -c1,3 |\
	  $(SED) -E '/,CAT/d;/,BACC/d;/,ACC/d;/,SMOKE/d;/,ASATS/d' |\
	  $(TEE) $@

orgs-london.csv:
	$(CF2) curl '/v3/organizations?per_page=5000' |\
	  $(JQ) --arg region london -r '.resources[] | [.metadata.annotations.owner, $$region, .name, .guid, .created_at, .suspended] | @csv' |\
	  $(HEADER) -a "owner,region,org_name,org_guid,created,suspended" |\
	  $(CSVSORT) -c1,3 |\
	  $(SED) -E '/,CAT/d;/,BACC/d;/,ACC/d;/,SMOKE/d;/,ASATS/d' |\
	  $(TEE) $@

processes.csv:
	$(CF1) curl '/v3/processes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > processes-dublin.csv
	$(CF2) curl '/v3/processes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > processes-london.csv
	$(CSVSTACK) -g dublin,london -n region processes-dublin.csv processes-london.csv > $@
	$(RM) processes-dublin.csv processes-london.csv 

routes.csv:
	$(CF1) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-dublin.csv
	$(CF2) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-london.csv
	$(CF2) curl '/v3/routes?page=2&per_page=5000' | $(IN2CSV) -f json -k resources | $(SED) 1d >> routes-london.csv
	$(CSVSTACK) -g dublin,london -n region routes-dublin.csv routes-london.csv > $@
	$(RM) routes-dublin.csv routes-london.csv 

security_groups.csv:
	$(CF1) curl '/v3/security_groups?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > security_groups-dublin.csv
	$(CF2) curl '/v3/security_groups?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > security_groups-london.csv
	$(CSVSTACK) -g dublin,london -n region security_groups-dublin.csv security_groups-london.csv > $@
	$(RM) security_groups-dublin.csv security_groups-london.csv 

services.csv:
	$(CF1) curl '/v3/service_instances?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > services-dublin.csv
	$(CF2) curl '/v3/service_instances?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > services-london.csv
	$(CSVSTACK) -g dublin,london -n region services-dublin.csv services-london.csv > $@
	$(RM) services-dublin.csv services-london.csv 

service_plans.csv:
	$(CF1) curl '/v3/service_plans?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > service_plans-dublin.csv
	$(CF2) curl '/v3/service_plans?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > service_plans-london.csv
	$(CSVSTACK) -g dublin,london -n region service_plans-dublin.csv service_plans-london.csv > $@
	$(RM) service_plans-dublin.csv service_plans-london.csv

spaces.csv:
	$(CF1) curl '/v3/spaces?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > spaces-dublin.csv
	$(CF2) curl '/v3/spaces?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > spaces-london.csv
	$(CSVSTACK) -g dublin,london -n region spaces-dublin.csv spaces-london.csv > $@
	$(RM) spaces-dublin.csv spaces-london.csv 

stacks.csv:
	$(CF1) curl '/v3/stacks?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $@
	
users.csv:
	$(CF1) curl '/v3/users?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > users-dublin.csv
	$(CF2) curl '/v3/users?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > users-london.csv
	$(CSVSTACK) -g dublin,london -n region users-dublin.csv users-london.csv > $@
	$(RM) users-dublin.csv users-london.csv 

start:
	$(STEAMPIPE service start)

query:
	$(STEAMPIPE) query

dependencies:
	mkdir -p $(PAAS_ENVDIR)/dublin
	mkdir -p $(PAAS_ENVDIR)/london
	
	pip3 install -r requirements.txt

	type cf || brew install cf-cli@8           # Cloud Foundry CLI
	type gawk || brew install gawk             # GNU awk	
	type gh || brew install gh                # github cli
	type glow || brew install glow             # glow cli for handling markdown
	type gsed || brew install gnu-sed          # GNU sed
	type jq || brew install jq.                # JSON wrangling tool
	type steampipe || brew install steampipe   # make cloud apis queryable via SQL 
	type yq || brew install yq                 # YAML tools

	$(STEAMPIPE) plugin install aws config csv docker github kubernetes net prometheus terraform zendesk 

issues:
	$(GH) issue list
