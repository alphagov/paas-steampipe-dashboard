-- number of working to decommission
with holidays_count as (
  select 
    count(*) as holidays
  from 
    holidays 
  where 
    (date::date > now()) and (date::date < '2023-12-23'::date)
)
select 
  ((EXTRACT(days from '2023-12-23'::date - now()))::int / 7) * 5 - (select holidays from holidays_count)  as working_days