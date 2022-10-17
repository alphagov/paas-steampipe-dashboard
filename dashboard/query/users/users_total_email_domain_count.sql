select
    count(distinct(split_part(presentation_name, '@', 2))) as domain_count
from
    users
where
    presentation_name ~ '@'