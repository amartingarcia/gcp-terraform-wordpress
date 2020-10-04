resource "google_dns_record_set" "wordpres_sql_record" {
  name         = "wordpress-cloudsql-${terraform.workspace}.${data.terraform_remote_state.vpc.outputs.private_dns_zone.dns_name}"
  managed_zone = data.terraform_remote_state.vpc.outputs.private_dns_zone.name
  type         = "A"
  ttl          = 30

  rrdatas = [google_sql_database_instance.wordpress_instance.ip_address[0].ip_address]
}