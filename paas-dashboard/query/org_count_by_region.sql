select 
	region,
	count(*) as org_count 
from 
	orgs
group by 
	region
