dashboard "buildpacks_report" {
  title = "GOV.UK PaaS buildpacks report"
  table {
    width = 12
    sql   = <<-EOQ
      select
	      position, 
        name, 
        filename, 
        created_at, 
        updated_at
    from 
      cf_buildpack_v2 
    order by
      position
    EOQ
  }
}