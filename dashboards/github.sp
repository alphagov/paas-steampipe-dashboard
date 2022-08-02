card "github_paas_repo_count" {
  type = "info"
  icon = "hashtag"
  label = "paas repo count"
  sql = query.paas_github_repos_count.sql
  width = "2"
  href = "${dashboard.github_repos_report.url_path}"
}

dashboard "github_repos_report" {
  title = "GOV.UK PaaS GitHub repos report"
  table {
    width = 12
    sql = query.paas_github_repos.sql
  }
  tags = {
    service = "github"
    type     = "report"
  }
}