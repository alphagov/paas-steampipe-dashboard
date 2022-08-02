card "services_count" {
  type = "info"
  icon = "hashtag"
  label = "services count"
  sql = query.services_count.sql
  width = "2"
  href = "${dashboard.services_report.url_path}"
}

dashboard "services_report" {
  title = "GOV.UK PaaS services report"
  table {
    width = 12
    sql = query.services.sql
  }
}