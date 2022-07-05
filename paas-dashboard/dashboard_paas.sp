dashboard "dashboard_paas" {
  title = "GOV.UK PaaS dashboard"


  card {
    type = "default"
    label = "org count"
    sql = "select count(*) as org_count from orgs"
    width = "2"
    href="https://cloud.service.gov.uk"
  }

  card {
    type = "default"
    label = "department count"
    sql = "select count(distinct owner) as department_count from orgs"
    width = "2"
    href="https://cloud.service.gov.uk"
  }


}
