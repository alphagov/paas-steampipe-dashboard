select
    region,
    sum(vm_count::integer) as count
from
    virtual_machines
group by
    region
order by
    count desc
