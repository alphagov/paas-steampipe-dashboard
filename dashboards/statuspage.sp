card "statuspage" {
    type = "info"
    icon = "information-circle"
    label = "statuspage latest"
    sql = statuspage_latest.sql
    width = "2"
}

table "statuspage" {
    width = 4
    sql = query.statuspage_posts.sql
}

dashboard "statuspage" {
    title = "GOV.UK PaaS statuspage dashboard"
    card {
        base = card.statuspage_latest
    }
    table {
        base = table.statuspage
    }
  tags = {
    service = "statuspage"
    type     = "dashboard"
  }
}