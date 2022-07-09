
dashboard "orgs-report" {
  title = "GOV.UK PaaS Orgs report"

  table {
  width = 12
  sql   = <<-EOQ
select
	region,org_name,owner,created
from orgs 
order by 
	region, 
	org_name
EOQ
  }

}
