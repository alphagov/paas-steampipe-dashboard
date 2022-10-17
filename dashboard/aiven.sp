
card "aiven_instances_count" {
  type = "info"
  icon = "hashtag"
  label = "aiven instance count"
  sql = query.aiven_instances_count.sql
  width = "2"
 }

 card "elasticsearch_count" {
  type = "info"
  icon = "hashtag"
  label = "aiven elasticsearch count"
  sql = query.elasticsearch_count.sql
  width = "2"
 }

 card "opensearch_count" {
  type = "info"
  icon = "hashtag"
  label = "aiven opensearch count"
  sql = query.opensearch_count.sql
  width = "2"
 }

 card "influxdb_count" {
  type = "info"
  icon = "hashtag"
  label = "aiven influxdb count"
  sql = query.influxdb_count.sql
  width = "2"
 }

table "aiven_instances" {
  width = 12
  sql = query.aiven_instances.sql
 }
 

dashboard "aiven__report" {
  title = "GOV.UK PaaS Aiven dashboard"
  table {
    base = table.aiven_instances
  }
  tags = {
    service = "aiven"
    type     = "report"
  }
}

dashboard "aiven" {
  title = "GOV.UK PaaS Aiven dashboard"
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
  tags = {
    service = "aiven"
    type     = "dashboard"
  }
}
