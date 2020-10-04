## DNS resources
#resource "google_dns_record_set" "load_balancing" {
#  name         = "test"
#  managed_zone = data.terraform_remote_state.dns.outputs.public_zone_dns.name
#  type         = "A"
#  ttl          = 30
#
#  rrdatas = [google_compute_global_forwarding_rule.allow_http.ip_address]
#}