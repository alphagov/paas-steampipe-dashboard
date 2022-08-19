select 
  region,
  name,
  type,
  created_at
from
  service_instances
order by 
  region,
  name,
  type