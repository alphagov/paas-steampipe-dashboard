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
	$(RM) orgs*.csv
	$(RM) virtual_machines.csv

dashboard:
	$(STEAMPIPE) dashboard --workspace-chdir paas-dashboard

data:
	$(VISIDATA) .

extract-data: orgs.csv virtual_machines.csv

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
	$(CF) login --sso 
		
logout:
	$(CF1) logout
	$(CF2) logout


orgs.csv: orgs-dublin.csv orgs-london.csv
	$(CSVSTACK) orgs-dublin.csv orgs-london.csv |\
		$(AWK) -F, -e '$$1 == ""  {print "UNDEFINED" $$0}; $$1 != "" {print $$0}' |\
    	$(CSVSORT) -c1,2 |\
      	$(CSVFORMAT) -U 1 > $@
		
orgs-dublin.csv:
	$(CF1) curl '/v3/organizations?per_page=1000' |\
	  $(JQ) --arg region dublin -r '.resources[] | [.metadata.annotations.owner, $$region, .name, .guid, .created_at, .suspended] | @csv' |\
	  $(HEADER) -a "owner,region,org_name,org_guid,created,suspended" |\
	  $(CSVSORT) -c1,3 |\
	  $(SED) -E '/,CAT/d;/,BACC/d;/,ACC/d;/,SMOKE/d;/,ASATS/d' |\
	  $(TEE) $@

orgs-london.csv:
	$(CF2) curl '/v3/organizations?per_page=1000' |\
	  $(JQ) --arg region london -r '.resources[] | [.metadata.annotations.owner, $$region, .name, .guid, .created_at, .suspended] | @csv' |\
	  $(HEADER) -a "owner,region,org_name,org_guid,created,suspended" |\
	  $(CSVSORT) -c1,3 |\
	  $(SED) -E '/,CAT/d;/,BACC/d;/,ACC/d;/,SMOKE/d;/,ASATS/d' |\
	  $(TEE) $@

services-dublin.csv:
	$(CF1) service-use -f csv | gsed 's/, /,/g' | tee $@


#csvstack -g dublin,london -n region data/dublin-services.csv data/london-services.csv |
#	csvsort -c1,2 |
#	csvformat -U 1 |
#	tee data/all-services.csv

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

hack:
	$(CF1) oauth-token /dev/null || (open $(LOGIN1)) 
