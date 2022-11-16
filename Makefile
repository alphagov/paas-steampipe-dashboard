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
EDITOR            := vim
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
# IS_ON_VPN         := $(shell bin/is_on_VPN)
TIMESTAMP	      := $(shell date -Iseconds)

# app configuration
APP_NAME                  := paas-dashboard
AWS_EXPERIMENTS_PROFILE   := paas-experiments-admin      # admin creds against experiments
AWS_PROD_PROFILE          := paas-prod-ro                      # read only creds against production
AWS_DEFAULT_REGION        := eu-west-1
COPILOT_DOMAIN            := govukpaasmigration.digital        # domain for copilot app
DOCKER_IMAGE              := paas-steampipe-dashboard
ASSUME_ROLE_EXPERIMENTS   := $(GDS_CLI) aws $(AWS_EXPERIMENTS_PROFILE) -r $(AWS_DEFAULT_REGION)    
ASSUME_ROLE_PROD          := $(GDS_CLI) aws $(AWS_PROD_PROFILE) -r $(AWS_DEFAULT_REGION) 

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
AIVEN_FILES       := data/aiven/aiven_instances.csv data/aiven/aiven_instances.json
AWS_FILES         := ec2_instances.csv ec2_instance_types.csv application_load_balancers.csv cloudfront_distributions.csv ebs_snapshots.csv ebs_volumes.csv elasticache_clusters.csv network_load_balancers.csv rds_db_instances.csv rds_db_snapshots.csv sqs_queues.csv s3_buckets.csv vpcs.csv vpc_internet_gateways.csv vpc_subnets.csv
CSV_FILES         := data/holidays.csv data/govuk_paas/bills.csv data/govuk_paas/organizations.csv data/aws/paas_accounts.csv data/govuk_paas/routes.csv data/govuk_paas/virtual_machines.csv
CSV_FILES1        := apps.csv buildpacks.csv domains.csv feature_flags.csv isolation_segments.csv organization_quotas.csv processes.csv security_groups.csv service_brokers.csv service_instances.csv service_offerings.csv service_plans.csv service_route_bindings.csv spaces.csv space_quotas.csv stacks.csv users.csv

# STEAMPIPE config
STEAMPIPE_PLUGINS := config csv github googlesheets net prometheus rss terraform zendesk

# macro definitions
define api2csv
$(CF1) curl '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-dublin.csv
$(CF2) curl '/v3/$1?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > $1-london.csv
$(CSVSTACK) -g dublin,london -n region $1-dublin.csv $1-london.csv > data/govuk_paas/$@
$(RM) $1-dublin.csv $1-london.csv 
endef

define record_command
$(ASCIINEMA_APPEND) -c $1 docs/casts/$2.cast
endef

$(AWS_FILES):
	$(STEAMPIPE) query dashboard/query/aws/$(@:.csv=.sql) --output csv > data/aws/$@

$(CSV_FILES1):
	$(call api2csv,$(basename $@))

aws_data: $(AWS_FILES)

aws-prod: aws-prod-console aws-prod-shell

aws-experiments: aws-experiments-console aws-experiments-shell

aws-experiments-shell:
	@echo "ensure you are on the vpn"
	@echo "open google authenticator on phone to provide AWS MFA token"
	$(ASSUME_ROLE_EXPERIMENTS) -- $(SHELL) -l

aws-experiments-console:
	$(ASSUME_ROLE_EXPERIMENTS) -l

aws-experiments-query:
	$(ASSUME_ROLE_EXPERIMENTS) -- $(STEAMPIPE) query

aws-prod: aws-prod-console aws-prod-shell

aws-prod-shell:
	@echo "ensure you are on the vpn"
	@echo "open google authenticator on phone to provide AWS MFA token"
	$(ASSUME_ROLE_PROD) -- $(SHELL) -l

aws-prod-console:
	$(ASSUME_ROLE_PROD) -l

aws-prod-query:
	$(ASSUME_ROLE_PROD) -- $(STEAMPIPE) query

data/govuk_paas/bills.csv: bin/paas-pmo-merge.vd
	$(CSVSTACK) --filenames raw-bills/paas-pmo-org-spend*.csv | $(VISIDATA) -f csv -p $^ -b -o $@

build:
	$(DOCKER) build -t $(DOCKER_IMAGE) .

check-aiven:
	@-which avn
	@-avn --version
	@-avn user info

check-all: check-network check-vpn check-aws check-aiven check-cf check-steampipe

check-aws:
	@-which aws
	@-aws --version
	@echo "AWS_ACCESS_KEY_ID: $(AWS_ACCESS_KEY_ID)"
	@echo "AWS_REGION: $(AWS_REGION)"
	@echo "AWS_SESSION_EXPIRATION: $(AWS_SESSION_EXPIRATION)"
	@echo "AWS_VAULT: $(AWS_VAULT)"
	@-aws sts  get-caller-identity

check-cf:
	@-which cf
	@-cf version 
	@-$(CF1) oauth-token &> /dev/null || echo "no connection to dublin foundry"
	@-$(CF2) oauth-token &> /dev/null || echo "no connection to london foundry"

check-csv: docs/schemata.csv
	@csvcut -c file,field docs/schemata.csv | csvgrep -c field -m _ctx | gsed 1d
	@find data -type f -iname "*.csv" -size 0
	# check that bills.csv exists
	# check that the number of csv files = 

check-network:
	@speedtest

check-steampipe:
	@-which steampipe
	@-steampipe -v
	@-steampipe plugin list
	@-steampipe service status
	@steampipe query --output  csv  'select * from aws_account' | csvcut -c title,account_id,organization_master_account_id | csvlook

check-vpn:
	@echo "vpn: $(shell bin/is_on_VPN)"

clean:
	@$(RM) data/.DS_Store
	@$(RM) data/holidays.csv
	@find data/aiven -type f -exec $(RM) {}  \;
	@find data/aws -type f -exec  $(RM) {} \;
	@find data/govuk_paas -type f -exec  $(RM) {}  \;
	@$(RM) *-dublin.csv
	@$(RM) *-london.csv
	@$(RM) docs/schemata.csv

.PHONY:  dashboard
dashboard:
	$(STEAMPIPE) dashboard --browser=false --mod-location dashboard 

.PHONY: data
data: login extract-data last-updated

data/holidays.csv:
	$(CURL) -s https://www.gov.uk/bank-holidays.json | $(JQ)  '."england-and-wales"'  | $(IN2CSV) -f json -k events  > $@

data/aiven/aiven_instances.json:
	$(AIVEN_CLI) service list --json > $@ 

data/aiven/aiven_instances.csv: data/aiven/aiven_instances.json
	$(JQ) -r  '.[] | [.service_name, .cloud_name, .service_type, .plan] | @csv' $^ | $(HEADER) -a "service_name,region,service_type,plan" > $@

data/aws/paas_accounts.csv:
	(echo "---";\
	echo "accounts:";\
	for e in `$(GDS_CLI) aws | $(EGREP) paas | $(SED) -E -e 's/^[ \t]+//' -e 's/ +[a-zA-Z0-9_ /t]+//' | $(SORT)`;\
	do \
  		echo "  -";\
  		gds aws $$e -d --skip-ip-range-checks | $(SED) -E 's/^/    /';\
	done) | $(YQ) -o json | $(IN2CSV) -f json -k accounts > $@ 

data/govuk_paas/organizations.csv:
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

data/govuk_paas/routes.csv:
	$(CF1) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-dublin.csv
	$(CF2) curl '/v3/routes?page=1&per_page=5000' | $(IN2CSV) -f json -k resources > routes-london.csv
	$(CF2) curl '/v3/routes?page=2&per_page=5000' | $(IN2CSV) -f json -k resources | $(SED) 1d >> routes-london.csv
	$(CSVSTACK) -g dublin,london -n region routes-dublin.csv routes-london.csv > $@
	$(RM) routes-dublin.csv routes-london.csv

data/govuk_paas/virtual_machines.csv:
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,dublin,/' | $(SORT) | $(HEADER) -a environment,region,vm_type,vm_count > $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/prod-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/production,london,/' | $(SORT) >> $@
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/env-specific/stg-lon.yml | $(GREP) _instances | $(SED) -E -e 's/_instances//' -e 's/: /,/' -e 's/^/staging,london,/' | $(SORT) >> $@ 
	$(CURL)  $(PAAS_CF_REPO)/main/manifests/cf-manifest/isolation-segments/prod/govuk-notify-production.yml | $(GREP) number_of_cells | $(SED) -E -e 's/number_of_cells//' -e 's/: /,/' -e 's/^/production,dublin,isolation-segment/' | $(SORT) >> $@ 

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

docs/datamodel.png: docs/datamodel.drawio
	$(DRAWIO) -x -e  -o $@ $<

docs/datamodel.svg: docs/datamodel.drawio
	$(DRAWIO) -x -e  -o $@ $<

docs/schemata.csv: 
	(for f in `find data -type f -iname "*.csv" | sort`;\
	do \
	  $(CSVCUT) -n $$f | $(SED) -E -e "s|^ +|$$f,|" -e "s/: +/,/";\
	done) | $(HEADER) -a 'file,seq,field' > $@

docs/schemata.md:
	(echo '<!-- generated file so do not edit by hand! -->';\
	echo '# Schemata';\
	echo;\
	for f in `find data -type f -iname "*.csv" | sort`;\
	do \
		echo "##  $$f";\
		echo;\
		echo '|seq|field|' ;\
		echo '---|------|' ;\
		csvcut -n $$f | $(SED) -E -e 's# +#|#' -e 's/: /|/' -e 's/$$/|/' ;\
		echo ;\
	done ) > $@

edit-data:
	$(VISIDATA) `$(FIND) data -type f -iname "*.csv"`

edit-model: docs/datamodel.drawio
	$(DRAWIO) $<

extract-aiven: $(AIVEN_FILES) 
extract-aws: $(AWS_FILES) 
extract-cf: $(CSV_FILES) $(CSV_FILES1)
extract-data: extract-cf extract-aiven extract-aws

issues:
	$(GH) issue list

kanban:
	$(OPEN) https://github.com/pauldougan/paas-steampipe-dashboard/projects/1

last-updated: data/settings.csv
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

logs:
	$(EDITOR) ~/.steampipe/logs/

menu:
	@$(EGREP) -E "^[0-9]{2}" Makefile | gsed 's/://'

open:
	$(OPEN) http://localhost:9194

play:
	@$(FIND) docs/casts -type f | $(SORT) | $(HEADER) -a "asciinema_cast" | $(VISIDATA) -f csv | $(SED) 1d | $(XARGS) -n 1 $(ASCIINEMA) play -s 4

publish-docs: docs/schemata.csv docs/schemata.md

publish-model:   docs/datamodel.svg docs/datamodel.png docs/schemata.md
	$(GIT) add $^
	$(GIT) commit -m "refresh model"

query:
	$(STEAMPIPE) query start: ;$(STEAMPIPE service start)

run:
	make | $(HEADER) -a "target" | $(VISIDATA) -f csv | $(SED) 1d | $(XARGS) -n 1 echo make
	
steampipe-mod:
	ls ~/Documents/GitHub/ | $(GREP) steampipe-mod | $(SORT) | $(HEADER) -a "mod" | $(VISIDATA) -f csv | $(SED) 1d | $(XARGS) -n 1 echo steampipe dashboard --workspace-chdir ~/Documents/GitHub/

status: README.md
	@$(GLOW) $<
	@$(GH) issue list

versions:
	@$(AIVEN_CLI) --version cd 
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

# copilot steps
01-app-init:
	$(call record_command, "copilot app init $(APP_NAME) --resource-tags department=GDS,team=govuk-paas,owner=paul.dougan --domain $(COPILOT_DOMAIN)",$@)
	
02-env-init-dev:
	$(call record_command, "copilot env init --aws-access-key-id $$AWS_ACCESS_KEY_ID --aws-secret-access-key $$AWS_SECRET_ACCESS_KEY --aws-session-token $$AWS_SESSION_TOKEN --default-config -a $(APP_NAME) -n dev --container-insights",$@)

02-env-init-staging:
	$(call record_command, "copilot env init --aws-access-key-id $$AWS_ACCESS_KEY_ID --aws-secret-access-key $$AWS_SECRET_ACCESS_KEY --aws-session-token $$AWS_SESSION_TOKEN --default-config -a $(APP_NAME) -n staging --container-insights",$@)

02-env-init-production:
	$(call record_command, "copilot env init --aws-access-key-id $$AWS_ACCESS_KEY_ID --aws-secret-access-key $$AWS_SECRET_ACCESS_KEY --aws-session-token $$AWS_SESSION_TOKEN --default-config --region 'eu-west-1' -a $(APP_NAME) -n production --container-insights",$@)

03-env-deploy-dev:
	$(call record_command, "copilot env deploy -a $(APP_NAME) -n dev",$@)

03-env-deploy-staging:
	$(call record_command, "copilot env deploy -a $(APP_NAME) -n staging",$@)

03-env-deploy-production:
	$(call record_command, "copilot env deploy -a $(APP_NAME) -n production",$@)

04-svc-init-dashboard:
	$(call record_command, "copilot svc init -d Dockerfile.dashboard -a $(APP_NAME) -n dashboard -t 'Backend Service'",$@)
	
05-svc-deploy-dashboard:
	$(call record_command, "copilot svc deploy -a $(APP_NAME) -e dev -n dashboard",$@)

06-svc-init-nginx:
	$(call record_command, "copilot svc init -d Dockerfile.nginx -a $(APP_NAME) -n nginx -t 'Load Balanced Web Service'",$@)

07-svc-deploy-nginx:
	$(call record_command, "copilot svc deploy -a $(APP_NAME) -e dev -n nginx",$@)
	
08-document-app:
	$(call record_command, "copilot app ls",$@)
	$(call record_command, "copilot app show -n $(APP_NAME)",$@)
	$(call record_command, "copilot env ls",$@)
	$(call record_command, "copilot env show -a $(APP_NAME)" -n dev",$@)
	$(call record_command, "copilot svc ls -a $(APP_NAME)",$@)
	$(call record_command, "copilot svc show -a $(APP_NAME) -n dashboard ",$@)
	$(call record_command, "copilot svc show -a $(APP_NAME) -n nginx ",$@)

09-svc-delete-nginx:
	$(call record_command, "copilot svc delete -a $(APP_NAME) -e dev -n nginx",$@)

10-svc-delete-dashboard:
	$(call record_command, "copilot svc delete -a $(APP_NAME) -e dev -n dashboard",$@)

11-env-delete-dev:
	$(call record_command, "copilot env delete -a $(APP_NAME) -n dev --yes",$@)

11-env-delete-staging:
	$(call record_command, "copilot env delete -a $(APP_NAME) -n staging --yes",$@)

11-env-delete-production:
	$(call record_command, "copilot env delete -a $(APP_NAME) -n production --yes",$@)

12-app-delete-app:
	$(call record_command, "copilot app delete -n $(APP_NAME)",$@)
