select 
    distinct date as last_bill
from bills 
order by 
    date desc 
limit 1