dashboard "departments_report" {
  title = "GOV.UK PaaS departments report"
  table {
    width = 12
    sql   = <<-EOQ
      select
 	      distinct owner
    from orgs 
    order by 
	    owner
    EOQ
  }
}