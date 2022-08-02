card "shared_routes_count" {
  type = "info"
  icon = "hashtag"
  label = "shared routes count"
  sql = query.routes_count.sql 
  width = "2"
  href = "${dashboard.routes_report.url_path}"
}

dashboard "routes_report" {
  title = "GOV.UK PaaS routes report"
  table {
    width = 12
    sql = query.routes.sql
  }
}