# http://localhost:9194/local.dashboard.dashboard_paas

dashboard "dashboard-paas" {
  title = "GOV.UK PaaS dashboard"

container {  
  title = "General"

  card {
    base = card.countdown_days
  }

  card {
    base = card.virtual_machines_count
  }

  card {
    base = card.buildpacks_count
  }

}

container {
  title = "Tenants"

  card {
    base = card.departments_count
  }
  
  card {
    base = card.organisations_count
  }
  
  card {
    base = card.users_count
  }
 
  card {
    base = card.orgs_count_suspended
  }
 
  card {
    base = card.orgs_expiring_trials_count
  }
 
}

container {
  title = "Domains and routes"

  card {
    base = card.private_domains_count
  }

  card {
    base = card.public_domains_count
  }

  card {
    base = card.shared_routes_count
  }


}

container {
  title = "Backing Services"
  
  card {
    base = card.services_count
  }
  
}

container {
  title = "GitHub"

  card {
    type = "info"
    icon = "hashtag"
    label = "paas repo count"
    sql = query.paas_github_repos_count.sql
    width = "2"
    href = "${dashboard.github_repos_report.url_path}"
  }

}

container {
  title = "Virtual machines"

  chart {
    base = chart.virtual_machines_by_type
  }

  chart {
    base = chart.virtual_machines_by_region
  }

  chart {
    base = chart.virtual_machines_by_environment
  }

}

  chart {
    type  = "donut"
    title = "Orgs by department"
    width = 4
    sql = query.orgs_count_by_department.sql
  }

container {
  text {
    base = text.footer
  }
}

}
