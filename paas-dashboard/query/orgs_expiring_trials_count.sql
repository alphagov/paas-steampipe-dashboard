select
	count(*) as expiring_soon
from orgs 
where 
	-- the number of days til expiry
	((created::date+90) - current_date) > 0 and suspended = 'False'