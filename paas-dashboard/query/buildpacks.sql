select
    position, 
    name, 
    filename, 
    to_char(created_at::date,'YYYY-MM-DD') as created_at, 
    updated_at
from 
    cf_buildpack_v2 
order by
    position