connection “prometheus” {
  plugin = “prometheus”
  address = “http://localhost:9090”
  metrics = [“prometheus_http_requests_.*”, “.*error.*”]
}