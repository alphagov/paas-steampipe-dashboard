
dashboard "expiry-report" {
  title = "GOV.UK PaaS Trial Org expiry report"

  table {

  width = 8

  sql   = <<-EOQ
select
	created::date, 
	created::date + 90 as trial_expiry_date,	
	(created::date + 90) - CURRENT_DATE as days_to_expiry,
	org_name, 
	owner 
from orgs 
where 
	((created::date+90) - current_date) > 0
order by 
	created::date

EOQ
  }

}
