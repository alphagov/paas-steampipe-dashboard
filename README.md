# PaaS dashboard

> a 🔥firebreak experiment using [Steampipe](https://steampipe.io/) to make a dashboard to monitor paas platform things.

# Overview

Steampipe provides an sql layer on top of a wide range of cloud platform services that have apis. This dashboard uses the mechanics of steampipe to build a set of dashboards over GOV.UK PaaS.

# Prerequisites

```
brew install steampipe
brew install jq
brew install yq
brew install cf-cli@8
pip3 install csvkit
pip3 install visidata
```

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



