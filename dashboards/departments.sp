dashboard "departments_report" {
  title = "GOV.UK PaaS departments report"
  table {
    width = 12
    sql = query.departments.sql
  }
}