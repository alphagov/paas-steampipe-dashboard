select
    published, title, link, feed_link
from 
    rss_item
where
    feed_link = 'https://www.cloudfoundry.org/foundryblog/security-advisory/feed/'