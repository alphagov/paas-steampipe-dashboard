card "statuspage_latest" {
    type = "info"
    icon = "information-circle"
    label = "statuspage latest"
    sql = query.statuspage_latest.sql
    width = "4"
}

table "statuspage" {
    width = 4
    sql = query.statuspage_posts.sql
}

dashboard "statuspage"  {
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