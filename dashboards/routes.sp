dashboard "routes_report" {
  title = "GOV.UK PaaS routes report"
  table {
    width = 12
    sql = query.routes.sql
  }
}