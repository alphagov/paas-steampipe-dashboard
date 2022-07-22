select 
	owner,
	count(*) as org_count 
from 
	orgs
group by 
	owner
