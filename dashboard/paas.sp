# http://localhost:9194/local.dashboard.paas

dashboard "paas" {
  title = "GOV.UK PaaS dashboard"
  tags = {
    service = "paas"
  type     = "dashboard"
  }
  container {  
    title = "Countdown"
    card {
      base = card.countdown_days
    }
    card {
      base = card.countdown_working_days
    }
    card {
      base = card.countdown_weeks
    }
  }

  container {
    title = "Tenants"
    container {
      card {
        base = card.departments_count
      }
      card {
        base = card.organisations_count
      }
      card {
        base = card.users_count
      }
    container {
      card {
        base = card.orgs_count_billable
      }
      card {
        base = card.orgs_count_suspended
      }
      card {
        base = card.orgs_expiring_trials_count
      } 
    }
    }
  } 

  container {
    title = "Bills"
    container {
      card {
        base = card.bills_total
      }
      card {
        base = card.bills_date_range
      }
    }
    container {
      card {
        base = card.bills_last_bill_date
      }
      card {
        base = card.bills_total_last_month
      }
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
    title = "Applications and processes"
    card {
      base = card.buildpacks_count
    }
    card {
      base = card.apps_count
    }
    card {
      base = card.processes_count
    }
  }
  
  container {
    title = "Backing Services"    
    card {
      base = card.services_count
    }
  }



  container {
    title = "AWS infrastructure"
    card {
      base = card.vpcs_count
    }
    card {
      base = card.application_load_balancers_count
    }
    card {
      base = card.ec2_instances_count
    }
    card {
      base = card.cloudfront_distributions_count
    }
    card {
      base = card.rds_db_instances_count
    }
    card {
      base = card.s3_buckets_count
    }
    card {
      base = card.sqs_queues_count
    }
    card {
      base = card.elasticache_clusters_count
    }
  }

  container {
    title = "Aiven infrastructure"
    card {
      base = card.aiven_instances_count
    }
    card {
      base = card.aiven_instances_count
    }
    card {
      base = card.elasticsearch_count
    }
      card {
      base = card.opensearch_count
    }
    card {
      base = card.influxdb_count
    }
  }



  container {
    title = "Source code"
    card {
      base = card.github_paas_repo_count
    }
  }

  container {
    text {
      base = text.footer
    }
  }
}
