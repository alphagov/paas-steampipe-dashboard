with paas_accounts as (
  select 
    "AccountNumber" as account_number,
    replace("Name",'-admin','') as account_name,
    "RoleArn" 
  from 
    paas_accounts 
  where 
    "Name" ~ '-admin' 
  order by 
    "AccountNumber"
)
select
  i.account_id,
  paas_accounts.account_name,
  region,
  availability_zone,
  db_instance_identifier,
  class,
  allocated_storage,
  backup_retention_period,
  deletion_protection,
  latest_restorable_time,
  storage_encrypted,
  engine,
  engine_version,
  create_time,
  multi_az,
  secondary_availability_zone,
  preferred_maintenance_window,
  storage_encrypted,
  vpc_id,
  tags::jsonb ->> 'Extensions' as extensions,
  tags::jsonb ->> 'Organization ID' as org_guid,
  tags::jsonb ->> 'Space ID' as space_guid,
  tags::jsonb ->> 'Service ID' as service_guid
  
from
  rds_db_instances i
  left join paas_accounts on i.account_id = paas_accounts.account_number 
