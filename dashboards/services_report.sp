dashboard "services_report" {
  title = "GOV.UK PaaS services report"
  table {
    width = 12
    sql = query.services.sql
  }
}