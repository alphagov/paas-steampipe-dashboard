select 
	region,
	count(*) as org_count 
from 
	organizations
group by 
	region
