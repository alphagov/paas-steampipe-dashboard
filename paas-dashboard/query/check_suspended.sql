select 
  org_name as resource, 
  case 
    when suspended = 'True' then 'alarm' 
    else 'ok' 
  end as status,
  case 
    when suspended = 'True' then 'org not suspended in the '||region||' region'
    else 'org is a billable account'
  end as reason,
  region,
  created
from 
    orgs