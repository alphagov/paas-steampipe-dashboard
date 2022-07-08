select 
	count(*) as suspended_org_count 
from 
	orgs
where 
	suspended::boolean = true 
