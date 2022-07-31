dashboard "virtual_machine_counts_report" {
  title = "GOV.UK PaaS virtual machine count report"
  table {
    width = 12
    sql = query.virtual_machine_counts.sql
  }
}