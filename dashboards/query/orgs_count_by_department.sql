select
	owner,
    count(*) as count
from
    organizations
group by
    owner
order by
    count desc