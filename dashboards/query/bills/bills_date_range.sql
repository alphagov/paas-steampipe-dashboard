select 
    min(date) || ' - ' ||  max(date) as date_range 
from 
    bills