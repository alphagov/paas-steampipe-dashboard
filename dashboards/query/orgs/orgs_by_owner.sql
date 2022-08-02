select 
	owner,
	org_name,
	region,
	created,
	suspended
from 
	organizations
order by 
	owner,
	org_name
