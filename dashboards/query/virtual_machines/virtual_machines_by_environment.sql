select
    environment,
    vm_type,
    sum(vm_count::integer) as count
from
    virtual_machines
group by
    environment, vm_type
order by
    count desc
