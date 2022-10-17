
card "countdown_days" {
    type = "info"
    icon = "hashtag"
    label = "calendar days countdown"
    sql = query.countdown_days.sql
    width = 2
}

card "countdown_working_days" {
    type = "info"
    icon = "hashtag"
    label = "working days countdown"
    sql = query.countdown_working_days.sql
    width = 2
}

card "countdown_weeks" {
    type = "info"
    icon = "hashtag"
    label = "countdown"
    sql = query.countdown_weeks.sql
    width = 2
}

text "footer" {
    width = 8
    type = "markdown"
    value = <<-EOM
        [github](https://github.com/pauldougan/paas-dashboard),  [kanban](https://github.com/pauldougan/paas-steampipe-dashboard/projects/1?add_cards_query=is%3Aopen)
    EOM
}