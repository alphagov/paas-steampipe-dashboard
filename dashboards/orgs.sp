control "suspended_orgs" {
  title = "Orgs that are suspended"
  sql = query.orgs_check_suspended.sql
}

chart "orgs_by_department" {
  type  = "donut"
  title = "Orgs by department"
  width = 4
  sql = query.orgs_count_by_department.sql
}

card "organisations_count" {
  type = "info"
  icon = "hashtag"
  label = "organisations count"
  sql = query.orgs_count.sql
  width = "2"
  href = "${dashboard.orgs_report.url_path}" 
}

card "orgs_count_suspended" {
  type = "alert"
  icon = "hashtag"
  label = "suspended org count"
  sql = query.orgs_count_suspended.sql
  width = "2" 
}

card "orgs_expiring_trials_count" {
  type = "alert"
  icon = "hashtag"
  label = "expiring trial orgs"
  sql = query.orgs_expiring_trials_count.sql
  width = "2"
  href = "${dashboard.orgs_trial_expiry_report.url_path}"
}

table "orgs_report" {
  width = 12
  sql = query.orgs.sql
  column "org_name" {
    href = "{{ .'pazmin_link' }}"
  }
  column "pazmin_link" {
    display = "none"
  }
}

dashboard "orgs_report" {
  title = "GOV.UK PaaS orgs report"
  table {
    base = table.orgs_report
  }
}

dashboard "orgs_trial_expiry_report" {
  title = "GOV.UK PaaS trial orgs expiry report"
  table {
    width = 12
    sql = query.orgs_expiring_trials.sql
  }
}
