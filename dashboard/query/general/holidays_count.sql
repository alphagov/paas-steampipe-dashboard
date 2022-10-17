select 
  count(*) 
from holidays 
where 
  (date::date > now()) and (date::date < '2023-12-23'::date)