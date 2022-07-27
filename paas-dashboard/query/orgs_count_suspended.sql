select 
	count(*) as suspended_org_count 
from 
	organizations
where 
	suspended::boolean = true 
