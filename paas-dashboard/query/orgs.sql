select 
	org_name, 
	region, 
	owner, 
	to_char(created::date,'YYYY-MM-DD') as created, 
	suspended
from 
	orgs
order by 
	org_name
