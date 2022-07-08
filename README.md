# PaaS dashboard

> a 🔥 [firebreak](https://insidegovuk.blog.gov.uk/2018/05/03/firebreaks-on-gov-uk/) experiment using [Steampipe](https://steampipe.io/) to make a dashboard to monitor [GOV.UK PaaS](https://cloud.service.gov.uk) platform things.

# Overview

[Steampipe](https://steampipe.io) provides an sql layer on top of a [wide range of cloud platform services](https://hub.steampipe.io/plugins) that have apis. 
This dashboard uses the mechanics of steampipe to build a set of dashboards over GOV.UK PaaS.

It uses the [CF CLI](https://github.com/cloudfoundry/cli) and paas credentials to access the API and list resources, 
the data is saved locally as csv files and accessed from a local steampipe dashboard running at http://localhost:9194/local.dashboard.dashboard_paas
using the [csv plugin](https://hub.steampipe.io/plugins/turbot/csv) because there is no
plugin available for accessing the cf API.

The dashboards pull data from the underlying csv files using sql and render the results as a dashboard.

# Prerequisites

Assumes you are on a mac with homebrew installed with `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

```
# homebrew packages
brew install cf-cli@8      # Cloud Foundry CLI
brew install gawk          # GNU awk
brew install gnu-sed       # GNU sed
brew install jq            # JSON wrangling tool
brew install steampipe     # make cloud apis queryable via SQL 
brew install yq            # YAML tools

# python tools
pip3 install csvkit        # csv wrangling tools
pip3 install visidata      # data wrangling swiss army penknife tool
```

a GOV.UK PaaS account with global auditor access

# Plan
- [ ] access high level inventory data for the platform as csv format compatible with the steampipe csv plugin
  - [x] orgs (including departments)
  - [ ] buildpacks
  - [ ] cells
  - [ ] apps
  - [ ] spaces
  - [ ] services 
  - [ ] routes
  - [ ] logdrains
  - [ ] cell count
- [ ] initial dashboard of high level counts
  - [x] add steampipe dependencies aws config csv github terraform zendesk docker kubernetes prometheus
  - [ ] configuring the csv plugin
  - [x] orgs
  - [x] departments
  - [x] suspended accounts
  - [x] list of orgs
  - [x] list of departments
  - [x] expiring trial accounts
  - [ ] cells
  - [ ] billable accounts
  - [ ] spaces
  - [ ] apps
  - [ ] services


# Usage

`make dependencies` to install all the necessary packages

`make all` to login, extract data and run dashboard

`make dashboard` to run the dashboard with the current data

`make data` to work with the data



