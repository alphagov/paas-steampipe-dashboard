card "private_domains_count" {
  type = "info"
  icon = "hashtag"
  label = "private domains count"
  sql   = query.private_domains_count.sql
  width = "2"
  href = "${dashboard.domains_report.url_path}"
}

card "public_domains_count" {
  type = "info"
  icon = "hashtag"
  label = "shared domains count"
  sql = query.public_domains_count.sql
  width = "2"
  href = "${dashboard.domains_report.url_path}"
}

dashboard "domains_report" {
  title = "GOV.UK PaaS domains report"
  table {
    width = 12
    sql = query.domains.sql
  }
  tags = {
    service = "domains"
    type     = "report"
  }
}

dashboard "domains" {
  title = "GOV.UK PaaS domains dashboard"
  card {
    base = card.public_domains_count
  }
  card {
    base = card.private_domains_count
  }
  table {
    width = 12
    sql = query.domains.sql
  }
  tags = {
    service = "domains"
    type     = "dashboard"
  }
}