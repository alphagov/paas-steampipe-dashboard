select
  count(*) as opensearch_count
from 
  aiven_instances
where 
  service_type = 'opensearch'