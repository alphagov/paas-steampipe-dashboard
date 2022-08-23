select 
	count(*) as billable_org_count 
from 
	organizations
where 
	suspended::boolean = false
