-- number of calendar days until the target decommission date for the paas platform
--- ${local.decommission_target_date}
select 
  (value::date - current_date) as days_to_decommission 
from 
  settings 
  where 
    key = 'decommission_date'