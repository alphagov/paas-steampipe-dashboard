card "apps_count" {
  type = "info"
  icon = "hashtag"
  label = "cf apps count"
  sql = query.apps_count.sql
  width = "2"
 }

card "processes_count" {
  type = "info"
  icon = "hashtag"
  label = "cf processes count"
  sql = query.processes_count.sql
  width = "2"
 }

dashboard "apps" {
  title = "GOV.UK PaaS Apps dashboard"
  card {
    base = card.apps_count
  }
  card {
    base = card.processes_count
  }
  tags = {
    service = "apps"
    type     = "dashboard"
  }
}
