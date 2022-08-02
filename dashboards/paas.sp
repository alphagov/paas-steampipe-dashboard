# http://localhost:9194/local.dashboard.paas

dashboard "paas" {
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
      base = card.github_paas_repo_count
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
    base = chart.orgs_by_department
  }

  container {
    text {
      base = text.footer
    }
  }
}