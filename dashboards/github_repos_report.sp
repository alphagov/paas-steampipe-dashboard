dashboard "github_repos_report" {
  title = "GOV.UK PaaS GitHub repos report"
  table {
    width = 12
    sql = query.paas_github_repos.sql
  }
}