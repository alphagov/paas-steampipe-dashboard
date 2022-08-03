select 
    date,
    region,
    sum("Spend_GBP_no_VAT"::numeric::money) as total_bills
from 
    bills
group by 
    date,
    region 
order by 
    date 