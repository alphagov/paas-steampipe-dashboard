select
    position, 
    name, 
    filename, 
    to_char(created_at::date,'YYYY-MM-DD') as created, 
    to_char(updated_at::date,'YYYY-MM-DD') as updated
from 
    buildpacks 
order by
    position