select 
    split_part(presentation_name, '@', 2) as domain,
    count(*)
from 
    users 
where 
    presentation_name ~ '@'
group by 
    domain