input "regions" {
  title = "regions"
  type  = "select"
  width = 2
  sql = query.regions_input.sql
}
input "departments" {
  title = "departments"
  type  = "select"
  width = 2
  sql = query.departments_input.sql
}

input "organizations" {
  title = "organizations"
  type  = "select"
  width = 3
  sql = query.organizations_input.sql
}


dashboard "input" {
  title = "GOV.UK PaaS input"
  input {
    base = input.regions
  }
  input {
    base = input.departments
  }
  input {
    base = input.organizations
  }
  tags = {
    service = "input"
    type     = "dashboard"
  }
}
