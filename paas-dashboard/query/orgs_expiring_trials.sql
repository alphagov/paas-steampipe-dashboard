select
	region,
	to_char(created::date,'YYYY-MM-DD') as created, 
	to_char(created::date + 90, 'YYYY-MM-DD') as trial_expiry_date,	
	(created::date + 90) - CURRENT_DATE as days_to_expiry,
	org_name, 
	owner,
	case 
      when region = 'london' then 'https://admin.london.cloud.service.gov.uk/organisations/' || org_guid
	  when region = 'dublin' then 'https://admin.cloud.service.gov.uk/organisations/' || org_guid
      else 'invalid region'
    end as pazmin_link

from organizations 
where 
	((created::date+90) - current_date) > 0 and suspended = 'False'
order by 
	created::date