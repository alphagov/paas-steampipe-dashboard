select
  "ServiceName", count(*)
from
  service_instances
order by 
  "ServiceName"
