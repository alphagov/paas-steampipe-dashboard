select
  published
from
  rss_item
where
  feed_link = 'https://status.cloud.service.gov.uk/history.atom'
order by 
  published desc
limit 1; 