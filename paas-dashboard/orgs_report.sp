dashboard "orgs_report" {
  title = "GOV.UK PaaS orgs report"
  table {
    width = 12
    sql = query.orgs.sql
  }
}