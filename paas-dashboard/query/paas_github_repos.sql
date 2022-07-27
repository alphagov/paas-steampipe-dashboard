-- https://docs.github.com/en/search-github/getting-started-with-searching-on-github/about-searching-on-github
select 
    full_name,
    description,
    size,
    visibility,
    created_at,
    pushed_at,
    archived,
    fork,
    forks_count,
    watchers_count,
    stargazers_count,
    subscribers_count
from 
    github_search_repository 
where 
    query = 'user:alphagov paas in:name'
order by 
    full_name