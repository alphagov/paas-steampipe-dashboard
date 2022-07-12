dashboard "buildpacks_report" {
  title = "GOV.UK PaaS buildpacks report"
  table {
    width = 12
    sql = query.buildpacks.sql
  }
}