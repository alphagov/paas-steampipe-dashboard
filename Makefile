.DEFAULT_GOAL 	  := menu

# commands
AGG               := agg
AIVEN_CLI         := avn
ASCIINEMA         := asciinema
ASCIINEMA_APPEND  := $(ASCIINEMA) rec --append
ASCIINEMA_REC     := $(ASCIINEMA) rec --overwrite
AWK               := gawk
CF                := cf
COPILOT_CLI       := copilot
CSVCUT            := csvcut
CSVFORMAT         := csvformat 
CSVGREP           := csvgrep
CSVJSON           := csvjson
CSVSORT           := csvsort
CSVSQL            := csvsql
CSVSTACK          := csvstack
CSVTOTABLE        := csvtotable
CURL              := curl -s
DOCKER            := docker
DRAWIO            := /Applications/draw.io.app/Contents/MacOS/draw.io
EGREP             := egrep
FIND              := find
GDS_CLI           := gds  #use  version of the gds binary that contains this commit https://github.com/alphagov/gds-cli/commit/229ffb7a80c87fa85b0e8068d5d8a04b05ecdddf i.e. v5.35.0-7-g229ffb7 or later
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
SHELL             := /usr/local/bin/bash
SORT              := sort
STEAMPIPE         := steampipe
TEE               := tee
VISIDATA          := vd
XARGS             := xargs
YQ                := yq

# environment
DIR               := $(shell pwd)
IS_ON_VPN         := $(shell bin/is_on_VPN)
TIMESTAMP	      := $(shell date -Iseconds)

# app configuration
APP_NAME                  := paas-dashboard
AWS_EXPERIMENTS_PROFILE   := paas-experiments-admin      # admin creds against experiments
AWS_PROD_PROFILE          := paas-prod-ro                      # read only creds against production
COPILOT_DOMAIN            := govukpaasmigration.digital        # domain for copilot app
DOCKER_IMAGE              := paas-steampipe-dashboard
ASSUME_ROLE_EXPERIMENTS   := $(GDS_CLI) aws $(AWS_EXPERIMENTS_PROFILE) --   
ASSUME_ROLE_PROD          := $(GDS_CLI) aws $(AWS_PROD_PROFILE) --   

# cf configuration
CF_ORG            := admin
CF_SPACE          := billing
DUBLIN_DOMAIN     := cloud.service.gov.uk
LONDON_DOMAIN     := london.cloud.service.gov.uk
PAAS_ENVDIR       := ~/.govuk-paas
CF1               := CF_HOME=$(PAAS_ENVDIR)/dublin $(CF)
CF2               := CF_HOME=$(PAAS_ENVDIR)/london $(CF)
LOGIN1            := https://login.$(DUBLIN_DOMAIN)/passcode
LOGIN2            := https://login.$(LONDON_DOMAIN)/passcode
PAAS_CF_REPO      := https://raw.githubusercontent.com/alphagov/paas-cf

# data files
AIVEN_FILES       := aiven_instances.csv aiven_instances.json
AWS_FILES         := ec2_instances.csv ec2_instance_types.csv application_load_balancers.csv cloudfront_distributions.csv ebs_snapshots.csv ebs_volumes.csv elasticache_clusters.csv network_load_balancers.csv rds_db_instances.csv rds_db_snapshots.csv sqs_queues.csv s3_buckets.csv vpcs.csv
CSV_FILES         := $(AIVEN_FILES) $(AWS_FILES)  holidays.csv organizations.csv paas_accounts.csv routes.csv virtual_machines.csv
CSV_FILES1        := apps.csv buildpacks.csv domains.csv feature_flags.csv isolation_segments.csv organization_quotas.csv processes.csv security_groups.csv service_brokers.csv service_instances.csv service_offerings.csv service_plans.csv service_route_bindings.csv spaces.csv space_quotas.csv stacks.csv users.csv

# STEAMPIPE config
STEAMPIPE_PLUGINS := config csv github net prometheus rss terraform zendesk

# macro definitions
define api2csv
$(CF1) $(CURL) '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-dublin.csv
$(CF2) $(CURL) '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-london.csv
$(CSVSTACK) -g dublin,london -n region $1-dublin.csv $1-london.csv > $@
$(RM) $1-dublin.csv $1-london.csv 
endef

define record_command
$(ASCIINEMA_APPEND) -c $1 docs/casts/$2.cast
endef

$(AWS_FILES):
	$(STEAMPIPE) query dashboard/query/aws/$(@:.csv=.sql) --output csv > $@

$(CSV_FILES1):
	$(call api2csv,$(basename $@))

aiven_instances.json:
	$(AIVEN_CLI) service list --json > $@ 

aiven_instances.csv: aiven_instances.json
	$(JQ) -r  '.[] | [.service_name, .cloud_name, .service_type, .plan] | @csv' $^ | $(HEADER) -a "service_name,region,service_type,plan" > $@

aws_data: $(AWS_FILES)

aws-prod: aws-prod-console aws-prod-bash

aws-prod-shell:
	$(ASSUME_ROLE_PROD) $(SHELL) -l

aws-prod-console:
	$(ASSUME_ROLE_PROD) -l

aws-prod-query:
	$(ASSUME_ROLE_PROD) $(STEAMPIPE) query

build:
	$(DOCKER) build -t $(DOCKER_IMAGE) .

clean:
	@echo clean platform data
	$(RM) $(CSV_FILES) $(CSV_FILES1)
	$(RM) *-dublin.csv
	$(RM) *-london.csv

dashboard:
	$(STEAMPIPE) dashboard --browser=false --workspace-chdir dashboard ; 

data: login extract-data last-updated

deps:
	mkdir -p $(PAAS_ENVDIR)/dublin                     # environment set up for cf sessions
	mkdir -p $(PAAS_ENVDIR)/london	                   # environment set up for cf sessions
	pip3 install -r requirements.txt                   # python dependencies
	brew install drawio                                # drawio diagram editor
	type agg || brew install agg                       # asciinema to gif CLI
	type cf || brew install cf-cli@8                   # Cloud Foundry CLI
	type copilot || brew install aws/tap/copilot-cli   # AWS Copilot CLI
	type gawk || brew install gawk                     # GNU awk	
	type gds || brew install alphagov/gds/gds-cli      # GDS CLI (needs ssh config)
	type gh || brew install gh                         # github cli
	type glow || brew install glow                     # glow cli for handling markdown
	type gsed || brew install gnu-sed                  # GNU sed
	type jq || brew install jq.                        # JSON wrangling tool
	type steampipe || brew install steampipe           # make cloud apis queryable via SQL 
	type yq || brew install yq                         # YAML wrangling tool
	$(STEAMPIPE) plugin install $(STEAMPIPE_PLUGINS)   # install plugins
	$(STEAMPIPE) plugin update --all		   		   # upgrade plugins   

docs/datamodel.svg: docs/datamodel.drawio
	$(DRAWIO) -x -e  -o $@ $<

docs/datamodel.png: docs/datamodel.drawio
	$(DRAWIO) -x -e  -o $@ $<

docs/schemata.md:
	(echo '<!-- generated file so do not edit by hand! -->';\
	echo '# Schemata';\
	echo;\
	for f in *.csv;\
	do \
		echo "##  $$f";\
		echo;\
		echo '|seq|field|';\
		echo '---|------|';\
		csvcut -n $$f | $(SED) -E -e 's/ +/|/' -e 's/: /|/' -e 's/$$/|/';\
		echo;\
	done ) > $@

edit-csv:
	$(VISIDATA) *.csv

edit-model: docs/datamodel.drawio
	$(DRAWIO) $<

extract-data: $(CSV_FILES1) $(CSV_FILES)

holidays.csv:
	$(CURL) -s https://www.gov.uk/bank-holidays.json | $(JQ)  '."england-and-wales"'  | $(IN2CSV) -f json -k events  > $@

issues:
	$(GH) issue list

kanban:
	$(OPEN) https://github.com/pauldougan/paas-steampipe-dashboard/projects/1

last-updated: settings.csv
	$(SED) -i -E -e "/^last_updated/s/,.*/,$(TIMESTAMP)/" $^

login:
	# TODO if already logged in dont do anything
	$(OPEN) $(LOGIN1)
	$(CF1) api https://api.cloud.service.gov.uk
	$(CF1) login --sso -o $(CF_ORG) -s $(CF_SPACE)
	$(OPEN) $(LOGIN2)
	$(CF2) api https://api.london.cloud.service.gov.uk
	$(CF2) login --sso -o $(CF_ORG) -s $(CF_SPACE)
	$(CF1) api
	$(CF2) api

logout:
	$(CF1) logout
	$(CF2) logout

menu:
	@$(EGREP) -E "^[0-9]{2}" Makefile | gsed 's/://'

open:
	$(OPEN) http://localhost:9194

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

paas_accounts.csv:
	(echo "---";\
	echo "accounts:";\
	for e in `$(GDS_CLI) aws | $(EGREP) paas | $(SED) -E -e 's/^[ \t]+//' -e 's/ +[a-zA-Z0-9_ /t]+//' | $(SORT)`;\
	do \
  		echo "  -";\
  		gds aws $$e -d --skip-ip-range-checks | $(SED) -E 's/^/    /';\
	done) | $(YQ) -o json | $(IN2CSV) -f json -k accounts > $@ 

play:
	@$(FIND) casts -type f | $(SORT) | $(HEADER) -a "asciinema_cast" | $(VISIDATA) -f csv | $(SED) 1d | $(XARGS) -n 1 $(ASCIINEMA) play -s 4


publish-model:   docs/datamodel.svg docs/datamodel.png docs/schemata.md
	$(GIT) add $^
	$(GIT) commit -m "refresh model"

query:
	$(STEAMPIPE) query start: ;$(STEAMPIPE service start)

routes.csv:
	$(CF1) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-dublin.csv
	$(CF2) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-london.csv
	$(CF2) curl '/v3/routes?page=2&per_page=5000' | $(IN2CSV) -f json -k resources | $(SED) 1d >> routes-london.csv
	$(CSVSTACK) -g dublin,london -n region routes-dublin.csv routes-london.csv > $@
	$(RM) routes-dublin.csv routes-london.csv

run:
	$(DOCKER) run --rm -ti -p 8080:8080 $(DOCKER_IMAGE) 

schemata.csv: 
	(for f in *.csv;\
	do \
	  $(CSVCUT) $$f -n | $(SED) -E -e "s/^ +/$$f,/" -e "s/: +/,/";\
	done) |  $(HEADER) -a 'file,seq,field' > $@

status: README.md
	@$(GLOW) $<
	@$(GH) issue list

versions:
	@$(AIVEN_CLI) --version 
	@cf version
	@copilot version
	@$(DRAWIO) -V
	@$(GDS_CLI) -v
	@$(AWK) -V
	@gh version
	@glow -v
	@$(SED) --version
	@$(JQ) -V
	@$(STEAMPIPE) -v
	@$(YQ) -V
	make -v

virtual_machines.csv:
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,dublin,/' | $(SORT) | $(HEADER) -a environment,region,vm_type,vm_count > $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,london,/' | $(SORT) >> $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/stg-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/staging,london,/' | $(SORT) >> $@ 
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/isolation-segments/prod/govuk-notify-production.yml | $(GREP) number_of_cells | $(SED) -E -e 's/number_of_cells//' -e 's/: /,/' -e 's/^/production,dublin,isolation-segment/' | $(SORT) >> $@ 

# copilot steps
01-app-init:
	$(ASCIINEMA_REC) -c 'copilot app init $(APP_NAME) --resource-tags department=GDS,team=govuk-paas,owner=paul.dougan --domain $(DOMAIN)' casts/$@.cast
	
02-env-init:
	$(ASCIINEMA_REC)     -c 'copilot env init -a $(APP_NAME) -n dev --container-insights' 		casts/$@.cast

03-env-deploy:
	$(ASCIINEMA_REC)    -c 'copilot env deploy -a $(APP_NAME) -n dev' 		casts/$@.cast

04-svc-init-dashboard:
	$(ASCIINEMA_REC)    -c 'copilot svc init  -d dashboard/Dockerfile -a $(APP_NAME) -n dashboard -t "Backend Service"' casts/$@.cast

05-svc-deploy-dashboard:
	$(ASCIINEMA_REC)    -c 'copilot svc deploy -a $(APP_NAME) -e dev -n dashboard' casts/05-svc-deploy-dashboard.cast

06-svc-init-nginx:
	$(ASCIINEMA_REC)    -c 'copilot svc init -d nginx/Dockerfile.3 -a $(APP_NAME) -n nginx -t "Load Balanced Web Service"' casts/$@.cast

07-svc-deploy-nginx:
	
08-document-app:
	$(call record_command, "copilot app ls",$@)
	$(call record_command, "copilot app show -n $(APP_NAME)",$@)
	$(call record_command, "copilot env ls",$@)
	$(call record_command, "copilot env show -a $(APP_NAME)" -n dev",$@)
	$(call record_command, "copilot svc ls -a $(APP_NAME)",$@)
	$(call record_command, "copilot svc show -a $(APP_NAME) -n dashboard ",$@)
	$(call record_command, "copilot svc show -a $(APP_NAME) -n nginx ",$@)

09-svc-delete-nginx:
	$(ASCIINEMA_REC)    -c 'copilot svc delete -a $(APP_NAME) -e dev -n nginx' casts/$@.cast

10-svc-delete-dashboard:
	$(ASCIINEMA_REC)    -c 'copilot svc delete -a $(APP_NAME) -e dev -n dashboard' casts/$@.cast

11-app-delete-app:
	$(ASCIINEMA_REC)    -c 'copilot app delete -n $(APP_NAME)' casts/$@.cast

