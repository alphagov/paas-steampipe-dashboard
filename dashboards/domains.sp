dashboard "domains_report" {
  title = "GOV.UK PaaS domains report"
  table {
    width = 12
    sql = query.domains.sql
  }
}