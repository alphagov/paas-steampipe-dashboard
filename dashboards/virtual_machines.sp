chart "virtual_machines_by_type" {
    type  = "column"
    title = "Virtual machines by type"
    width = 4
    sql = query.virtual_machines_by_type.sql
}

chart "virtual_machines_by_region" {
    type  = "donut"
    title = "Virtual machines by region"
    width = 2
    sql = query.virtual_machines_by_region.sql
}

table "virtual_machine_counts" {
    width = 12
    sql = query.virtual_machine_counts.sql
  }

chart "virtual_machines_by_environment" {
    type  = "column"
    title = "Virtual machines by environment"
    width = 2
    sql =  query.virtual_machines_by_environment.sql
    legend {
        display = "none"
    }
}

dashboard "virtual_machine_counts_report" {
  title = "GOV.UK PaaS virtual machine count report"
  table {
    base = table.virtual_machine_counts
  }
}