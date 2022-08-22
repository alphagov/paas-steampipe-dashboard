-- number of working to decomission
select 
  (EXTRACT(days from '2023-12-23'::date - now()))::int as working_days