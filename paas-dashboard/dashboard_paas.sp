# http://localhost:9194/local.dashboard.dashboard_paas

dashboard "dashboard-paas" {
  title = "GOV.UK PaaS dashboard"


container {  
  title = "General"

 card {
    type = "info"
    icon = "hashtag"
    label = "countdown"
    sql = query.countdown_days.sql
    width = 2
  }
  
 card {
   type = "info"
   icon = "hashtag"
   label = "virtual machines"
   sql = query.virtual_machine_count.sql
   width = "2"
   href = "${dashboard.virtual_machine_counts_report.url_path}"
  }

 card {
    type = "info"
    icon = "hashtag"
    label = "buildpack count"
    sql = query.buildpacks_count.sql
    width = "2"
    href = "${dashboard.buildpacks_report.url_path}"
  }

}

container {
  title = "Tenants"

  card {
    type = "info"
    icon = "hashtag"
    label = "department count"
    sql = query.departments_count.sql
    width = "2"
    href = "${dashboard.departments_report.url_path}"
  }

  card {
    type = "info"
    icon = "hashtag"
    label = "organisation count"
    sql = query.orgs_count.sql
    width = "2"
    href = "${dashboard.orgs_report.url_path}" 
  }

 card {
    type = "alert"
    icon = "hashtag"
    label = "suspended org count"
    sql = query.orgs_count_suspended.sql
    width = "2"
  }
 
 card {
    type = "alert"
    icon = "hashtag"
    label = "expiring trial orgs"
    sql = query.orgs_expiring_trials_count.sql
    width = "2"
    href = "${dashboard.trial_expiry_report.url_path}"
  }

}

container {
  title = "Domains and routes"

  card {
      type = "info"
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
      type = "info"
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

  card {
      type = "info"
      icon = "hashtag"
      label = "shared routes count"
      sql = query.routes_count.sql 
      width = "2"
      href = "${dashboard.routes_report.url_path}"
    }

}

container {
  title = "Backing Services"
  
  card {
    type = "info"
    icon = "hashtag"
    label = "services count"
    sql = query.services_count.sql
    width = "2"
    href = "${dashboard.services_report.url_path}"
  }

}

  chart {
    type  = "donut"
    title = "Orgs by department"
    width = 4
    sql = <<-EOQ
      select
          owner,
          count(*) as count
      from
          orgs
      group by
          owner
      order by
          count desc
    EOQ
  }

  chart {
    type  = "column"
    title = "Virtual machines by type"
    width = 4
    sql = <<-EOQ
      select
          vm_type ,
          region,
          sum(vm_count::integer) as count
      from
          virtual_machines
      group by
          vm_type, region
      order by
          count desc
    EOQ
  }

  chart {
    type  = "donut"
    title = "Virtual machines by region"
    width = 2
    sql = <<-EOQ
      select
          region,
          sum(vm_count::integer) as count
      from
          virtual_machines
      group by
          region
      order by
          count desc
    EOQ
  }

  chart {
    type  = "column"
    title = "Virtual machines by environment"
    width = 2
    sql = <<-EOQ
      select
          environment,
          vm_type,
          sum(vm_count::integer) as count
      from
          virtual_machines
      group by
          environment, vm_type
      order by
          count desc
    EOQ
  }

  text {
    width = 8
    type = "markdown"
    value = <<-EOM
      [github](https://github.com/pauldougan/paas-dashboard),  [kanban](https://github.com/pauldougan/paas-steampipe-dashboard/projects/1?add_cards_query=is%3Aopen)
      EOM
  }

}

