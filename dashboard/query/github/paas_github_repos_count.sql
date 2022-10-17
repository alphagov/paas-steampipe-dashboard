-- https://docs.github.com/en/search-github/getting-started-with-searching-on-github/about-searching-on-github
select 
    count(*) as repo_count
from 
    github_search_repository 
where 
    query = 'user:alphagov paas in:name'