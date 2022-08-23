select
  count(*) as elasticsearch_count
from 
  aiven_instances
where 
  service_type = 'elasticsearch'