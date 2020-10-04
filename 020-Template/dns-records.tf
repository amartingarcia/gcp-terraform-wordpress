# DNS Records 
resource "google_dns_record_set" "wordpress_filestore" {
  name         = "filestore-${terraform.workspace}.${data.terraform_remote_state.vpc.outputs.private_dns_zone.dns_name}"
  managed_zone = data.terraform_remote_state.vpc.outputs.private_dns_zone.name
  type         = "A"
  ttl          = 30

  rrdatas = [google_filestore_instance.wordpress.networks[0].ip_addresses[0]]

  depends_on = [google_filestore_instance.wordpress]
}
