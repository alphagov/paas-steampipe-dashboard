select 
	owner,
	org_name,
	region,
	created,
	suspended
from 
	orgs
order by 
	owner,
	org_name
