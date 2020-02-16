resource "google_dns_record_set" "wordpres_sql_record" {
  name         = "wordpress-sql.${data.terraform_remote_state.dns.outputs.private_zone_dns.dns_name}"
  managed_zone = data.terraform_remote_state.dns.outputs.private_zone_dns.name
  type         = "A"
  ttl          = 30

  rrdatas = ["${google_sql_database_instance.wordpress_instance.ip_address[0].ip_address}"]
}