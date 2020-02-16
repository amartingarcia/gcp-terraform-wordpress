# Public Zone
output "public_zone_dns" {
  value = google_dns_managed_zone.public_zone
}

# Private Zone
output "private_zone_dns" {
  value = google_dns_managed_zone.private_zone
}