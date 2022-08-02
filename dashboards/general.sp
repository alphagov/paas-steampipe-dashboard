  locals {
    decommission_target_date = "2022-12-22"
  } 

card "countdown_days" {
    type = "info"
    icon = "hashtag"
    label = "countdown"
    sql = query.countdown_days.sql
    width = 2
  }

text "footer" {
    width = 8
    type = "markdown"
    value = <<-EOM
        [github](https://github.com/pauldougan/paas-dashboard),  [kanban](https://github.com/pauldougan/paas-steampipe-dashboard/projects/1?add_cards_query=is%3Aopen)
    EOM
}