select
	count(*)
from orgs 
where 
	((created::date+90) - current_date) > 0