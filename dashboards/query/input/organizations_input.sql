select
    distinct org_name as label,
    org_name as value
from 
    organizations 
order by 
    label