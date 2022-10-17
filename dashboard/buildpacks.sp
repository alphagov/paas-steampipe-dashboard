card "buildpacks_count" {
  type = "info"
  icon = "hashtag"
  label = "buildpack count"
  sql = query.buildpacks_count.sql
  width = "2"
  href = "${dashboard.buildpacks_report.url_path}"
}

table "buildpacks" {
  width = 12
  sql = query.buildpacks.sql
}

dashboard "buildpacks_report" {
  title = "GOV.UK PaaS buildpacks report"
  table {
    base = table.buildpacks
  }
  tags = {
    service = "buildpacks"
    type     = "report"
  }

}

dashboard "buildpacks" {
  title = "GOV.UK PaaS buildpacks dashboard"
  card {
    base = card.buildpacks_count
  }
  table {
    base = table.buildpacks
  }
  tags = {
    service = "buildpacks"
    type     = "dashboard"
  }
}
