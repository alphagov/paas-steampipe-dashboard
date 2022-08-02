select
	'shared' as label,
	count(*) as value
 from 
  cf_shared_domain_v2 
UNION
select
	'private' as label,
	count(*) as value
from 
  cf_private_domain_v2 
order by 
  label