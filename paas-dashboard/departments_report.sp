
dashboard "departments-report" {
  title = "GOV.UK PaaS Departments report"

  table {
  width = 12
  sql   = <<-EOQ
select
	distinct  owner
from orgs 
order by 
	owner
EOQ
  }

}
