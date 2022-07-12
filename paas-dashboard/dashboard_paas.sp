# http://localhost:9194/local.dashboard.dashboard_paas

dashboard "dashboard-paas" {
  title = "GOV.UK PaaS dashboard"

  text {
    width = 4
    type = "markdown"
    value = <<-EOM
      show key measures of the platform on a steampipe dashboard (see [github](https://github.com/pauldougan/paas-dashboard) for code or the [kanban](https://github.com/pauldougan/paas-steampipe-dashboard/projects/1?add_cards_query=is%3Aopen))
      EOM
  }

  card {
    type = "ok"
    icon = "hashtag"
    label = "organisation count"
    sql = "select count(*) as organisations from orgs"
    width = "2"
    href = "${dashboard.orgs_report.url_path}" 
  }

  card {
    type = "ok"
    icon = "hashtag"
    label = "department count"
    sql = "select count(distinct owner) as departments from orgs"
    width = "2"
    href = "${dashboard.departments_report.url_path}"
  }

 card {
    type = "ok"
    icon = "hashtag"
    label = "suspended org count"
    sql = "select count(*) as suspended from orgs where suspended = 'True'"
    width = "2"
  }
 
 card {
    type = "ok"
    icon = "hashtag"
    label = "expiring trial orgs"
    sql = "select count(*) as expiring_soon from orgs where ((created::date+90) - current_date) > 0"
    width = "2"
    href = "${dashboard.trial_expiry_report.url_path}"
  }

 card {
    type = "ok"
    icon = "hashtag"
    label = "buildpack count"
    sql = "select count(*) as buildpacks from cf_buildpack_v2"
    width = "2"
    href = "${dashboard.buildpacks_report.url_path}"
  }

  card {
      type = "ok"
      icon = "hashtag"
      label = "private domains count"
      sql   = <<-EOQ
        select
          count(*) as private_domains
        from 
          cf_private_domain_v2 
      EOQ
      width = "2"
      href = "${dashboard.domains_report.url_path}"
    }

  card {
      type = "ok"
      icon = "hashtag"
      label = "shared domains count"
      sql   = <<-EOQ
        select
          count(*) as shared_domains
        from 
          cf_shared_domain_v2 
      EOQ
      width = "2"
      href = "${dashboard.domains_report.url_path}"
    }

}
