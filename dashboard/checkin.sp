dashboard "checkin" {
  title = "GOV.UK PaaS decommision check-in dashboard"
  text {
      width = 8
      type = "markdown"
      value = <<-EOM
      This dashboard is for the fornightly check in with the leadership team to review the progress of the GOV.UK PaaS decommission.
      
      EOM
  }
  tags = {
  service = "checkin"
  type     = "dashboard"
  }
}


