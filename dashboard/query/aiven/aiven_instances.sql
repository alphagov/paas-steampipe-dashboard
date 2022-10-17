select
  service_name,
  replace(region,'aws-','') as region,
  service_type,
  plan
from 
  aiven_instances