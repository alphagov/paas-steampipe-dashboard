select 
  "AccountNumber",
  replace("Name",'-admin','') as Name,
  "RoleArn" 
from 
  paas_accounts 
where 
  "Name" ~ '-admin' 
order by 
  "AccountNumber"