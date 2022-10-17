select 
    distinct presentation_name as email 
from 
    users 
where 
    presentation_name ~ '@' 
order by 
    presentation_name