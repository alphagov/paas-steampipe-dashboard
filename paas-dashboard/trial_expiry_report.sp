dashboard "trial_expiry_report" {
  title = "GOV.UK PaaS trial expiry report"
  table {
    width = 8
    sql = query.expiring_trial_orgs.sql
  }
}