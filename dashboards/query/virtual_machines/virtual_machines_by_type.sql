select
    vm_type ,
    region,
    sum(vm_count::integer) as count
from
    virtual_machines
group by
    vm_type,
    region
order by
    count desc