select
	count(*)
from orgs 
where 
	-- the number of days til expiry
	((created::date+90) - current_date) > 0