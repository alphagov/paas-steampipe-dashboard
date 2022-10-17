select
	count(*) as private_domains
from 
	domains 
where 
	internal = 'True'