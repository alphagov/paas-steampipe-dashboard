card "bills_total" {
  type = "info"
  icon = "currency-pound"
  label = "total bills"
  sql = query.bills_total.sql
  width = "3"
}

card "bills_total_last_month" {
  type = "info"
  icon = "currency-pound"
  label = "total bills last month"
  sql = query.bills_total_last_month.sql
  width = "3"
}

card "bills_date_range" {
  type = "info"
  icon = "calendar"
  label = "bills date range"
  sql = query.bills_date_range.sql
  width = "4"
}

card "bills_last_bill_date" {
  type = "info"
  icon = "calendar"
  label = "last bill date"
  sql = query.bills_last_bill_date.sql
  width = "3"
}

chart "bills_total_by_region" {
  type  = "donut"
  title = "Total bills by region"
  width = 4
  sql = query.bills_total_by_region.sql
}

chart "bills_total_by_date" {
  type  = "column"
  title = "Total bills by date"
  width = 6
  sql = query.bills_total_by_date.sql
}

dashboard "bills" {
  title = "GOV.UK PaaS bills dashboard"
  card {
    base = card.bills_date_range
  }
  card {
    base = card.bills_total
  }
  card {
    base = card.bills_last_bill_date
  }
  card {
    base = card.bills_total_last_month
  }
  chart {
    base = chart.bills_total_by_region
  }
  chart {
    base = chart.bills_total_by_date
  }
  tags = {
  service = "bills"
  type     = "dashboard"
  }
}

