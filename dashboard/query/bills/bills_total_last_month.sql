select 
    sum("Spend_GBP_no_VAT"::numeric) as total_bills_last_month_GBP
from 
    bills
where
  date = (  select 
                distinct date as last_bill
            from 
                bills 
            order by 
            date desc 
            limit 1
        )