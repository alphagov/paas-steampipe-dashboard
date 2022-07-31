select 
  environment, 
  region, 
  vm_type,
  vm_count 
from 
  virtual_machines 
order by 
  environment, 
  region, 
  vm_type