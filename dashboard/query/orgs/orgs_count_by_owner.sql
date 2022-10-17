select 
	owner,
	count(*) as org_count 
from 
	organizations
group by 
	owner
