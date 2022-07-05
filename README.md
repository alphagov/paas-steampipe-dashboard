# PaaS dashboard

> a 🔥firebreak experiment using [Steampipe](https://steampipe.io/) to make a dashboard to monitor paas platform things.

# Overview

Steampipe provides an sql layer on top of a wide range of cloud platform services that have apis. This dashboard uses the mechanics of steampipe to build a set of dashboards over GOV.UK PaaS.

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

a GOV.UK PaaS account and access to an org and its resources

# Plan

- [ ] access high level inventory data for the platform as csv format compatible with the steampipe csv plugin
  - [ ] orgs
  - [ ] departments
  - [ ] apps
  - [ ] spaces
  - [ ] services 
- [ ] initial dashboard of high level counts
  - [ ] orgs
  - [ ] spaces
  - [ ] apps
  - [ ] services

# Usage

`make login`



