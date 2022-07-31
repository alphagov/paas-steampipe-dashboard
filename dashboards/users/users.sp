card "users_count" {
    type = "info"
    icon = "hashtag"
    label = "users count"
    sql = query.users_count.sql
    width = "2"
}

table "users" {
    width = 4
    sql = query.users.sql
}

dashboard "users" {
    title = "GOV.UK PaaS users dashboard"
 
    card {
        base = card.users_count
    }

    table {
        base = table.users
    }

}