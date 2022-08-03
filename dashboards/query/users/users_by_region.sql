select 
	region,
	count(*) as users
from 
	users
group by 
	region
