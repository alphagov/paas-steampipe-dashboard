-- number of weeks to decomission
select 
  (EXTRACT(days from '2023-12-23'::date - now()) / 7)::int  as weeks_to_decomission