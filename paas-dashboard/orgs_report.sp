dashboard "orgs_report" {
  title = "GOV.UK PaaS orgs report"
  table {
    width = 12
    sql   = <<-EOQ
      select
	      region,
        org_name,
        owner,
        created
    from 
      orgs 
    order by 
	    region, 
	    org_name
    EOQ
  }
}