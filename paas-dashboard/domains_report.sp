dashboard "domains_report" {
  title = "GOV.UK PaaS domains report"
  table {
    width = 12
    sql   = <<-EOQ
      select
        'shared' as domain_type,
        name
      from 
        cf_shared_domain_v2 
      UNION
      select
        'private' as domain_type,
        name
      from 
        cf_private_domain_v2 
      order by 
        domain_type,
        name
    EOQ
  }
}