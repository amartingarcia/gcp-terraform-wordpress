# VPC Outputs
## VPC Private Network
output "private_vpc" {
  value = google_compute_network.private_vpc
}

## VPC Private Subnet
output "private_subnet" {
  value = google_compute_subnetwork.private_subnet
}

## VPC Public Network
output "public_vpc" {
  value = google_compute_network.public_vpc
}

## VPC Public Subnet
output "public_subnet" {
  value = google_compute_subnetwork.public_subnet
}

## Common Firewall Rule
output "common_firewall_rule" {
  value = google_compute_firewall.common_rule
}

## SSH Firewall Rule
output "ssh_firewall_rule" {
  value = google_compute_firewall.ssh_rule
}

## DNS Public Zone
output "public_dns_zone" {
  value = google_dns_managed_zone.public_zone
}

## DNS Private Zone
output "private_dns_zone" {
  value = google_dns_managed_zone.private_zone
}
