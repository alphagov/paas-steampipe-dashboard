# How to add the billing data

## 1. get pmo export in csv from pazmin

- log into ireland https://login.cloud.service.gov.uk/login with global auditor
- goto https://admin.cloud.service.gov.uk/platform-admin
- export for PMO team in csv format for the month in question
- log into london https://admin.london.cloud.service.gov.uk/organisations with global auditor
- goto https://admin.london.cloud.service.gov.uk/platform-admin 
- export for PMO team in csv format for the month in question 

this will put the latest export files in ~/Downloads/

the names are of the form `paas-pmo-org-spend-{REGION}-{YEAR}-{MONTH}.csv

## 2. add new csvs to raw directory

`ls ~/Downloads/paas-pmo*.csv`

`mv ~/Downloads/paas-pmo*.csv raw-bills`

## 3. regenerate the bills.csv file

`make data/govuk_paas/bills.csv`

