dashboard "orgs_report" {
  title = "GOV.UK PaaS orgs report"
  table {
    width = 12
    sql = query.orgs.sql
    column "org_name" {
      href = "{{ .'pazmin_link' }}"
    }
    column "pazmin_link" {
      display = "none"
    }
  }
}
