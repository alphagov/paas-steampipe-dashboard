select 
    distinct date as last_bill_date
from bills 
order by 
    date desc 
limit 1