card "private_domains_count" {
  type = "info"
  icon = "hashtag"
  label = "private domains count"
  sql   = <<-EOQ
    select
      count(*) as private_domains
    from 
      cf_private_domain_v2 
  EOQ
  width = "2"
  href = "${dashboard.domains_report.url_path}"
}

card "public_domains_count" {
  type = "info"
  icon = "hashtag"
  label = "shared domains count"
  sql   = <<-EOQ
    select
      count(*) as shared_domains
    from 
      cf_shared_domain_v2 
  EOQ
  width = "2"
  href = "${dashboard.domains_report.url_path}"
}



dashboard "domains_report" {
  title = "GOV.UK PaaS domains report"
  table {
    width = 12
    sql = query.domains.sql
  }
}