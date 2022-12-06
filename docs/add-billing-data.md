# How to add the billing data

## 1. get pmo export in csv from pazmin

- [log into ireland](https://login.cloud.service.gov.uk/login) with global auditor and go to [admin](https://admin.cloud.service.gov.uk/platform-admin)
- view costs for PMO team in csv format for the month in question which will put a csv in  ~/Downloads
- [log into london](https://admin.london.cloud.service.gov.uk/organisations) with global auditor and go to [admin](https://admin.london.cloud.service.gov.uk/platform-admin) 
- view costs for PMO team in csv format for the month in question which will put a csv in  ~/Downloads

the names are of the form `paas-pmo-org-spend-{REGION}-{YEAR}-{MONTH}.csv

## 2. add new csvs to raw directory

`mv ~/Downloads/paas-pmo*.csv raw-bills`

## 3. regenerate the bills.csv file

`make data/govuk_paas/bills.csv`

