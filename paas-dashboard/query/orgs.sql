select 
	org_name, 
	region, 
	owner, 
	to_char(created::date,'YYYY-MM-DD') as created, 
	suspended,
	case 
      when region = 'london' then 'https://admin.london.cloud.service.gov.uk/organisations/' || org_guid
	  when region = 'dublin' then 'https://admin.cloud.service.gov.uk/organisations/' || org_guid
      else 'invalid region'
    end as pazmin_link
from 
	organizations
order by 
	org_name
