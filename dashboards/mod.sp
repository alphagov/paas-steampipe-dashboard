mod "paas-dashboard" {
  title = "GOV.UK PaaS dashboard"
  description = "a dashboard of GOV.UK PaaS platform metrics"
  categories = ["cf", "govuk-paas"]
  
  require {
    steampipe = "0.15.3"
    plugin "csv" {
      version = "0.3.2"
    }
    plugin "github" {
      version = "0.18.0"
    }
    plugin “rss” {
      version = “0.2.1”
    }
  }

}