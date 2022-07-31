dashboard "trial_expiry_report" {
  title = "GOV.UK PaaS trial expiry report"
  table {
    width = 12
    sql = query.orgs_expiring_trials.sql
  }
}