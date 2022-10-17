select 
	region,
	'https://' || url as url,
	created_at,
	updated_at
from 
	routes