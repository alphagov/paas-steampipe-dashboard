select 
    split_part(presentation_name, '@', 2) as domain, 
    presentation_name as email
from 
    users 
where 
    presentation_name ~ '@'
order by 
    domain