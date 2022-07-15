select
    position, 
    name, 
    filename, 
    to_char(created_at::date,'YYYY-MM-DD') as created, 
    to_char(updated_at::date,'YYYY-MM-DD') as updated
from 
    cf_buildpack_v2 
order by
    position