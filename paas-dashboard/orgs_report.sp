
dashboard "orgs-report" {
  title = "GOV.UK PaaS Orgs report"

  table {
  width = 12
  sql   = <<-EOQ
select
	region,org,owner,created
from orgs 
order by 
	region, 
	org
EOQ
  }

}
