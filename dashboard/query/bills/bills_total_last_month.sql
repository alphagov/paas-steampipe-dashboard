select 
    sum("Spend_GBP_no_VAT"::numeric::money) as total_bills_last_month
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