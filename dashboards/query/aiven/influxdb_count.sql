select
  count(*) as influxdb_count
from 
  aiven_instances
where 
  service_type = 'influxdb'