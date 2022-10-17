select
  count(*) as public_domains
from 
  domains 
where 
	internal = 'False'