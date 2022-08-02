select 
    sum("Spend_GBP_no_VAT"::numeric) as total_bills
from 
    bills