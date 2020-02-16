### VPC Network Private Outputs
# VPC Network
output "vpc_private" {
  value = google_compute_network.vpc_dev_private
}

# VPC SubNetwork Private Outputs
output "private_subnet01" {
  value = google_compute_subnetwork.subnet01_private_vpc
}


### VPC Network Public Outputs
# VPC Network
output "vpc_public" {
  value = google_compute_network.vpc_dev_public
}

# VPC SubNetwork Public Outputs
output "public_subnet01" {
  value = google_compute_subnetwork.subnet01_public_vpc
}


### VPC Network with subnets in distinct region Outputs
output "multiregion_public_vpc" {
  value = google_compute_network.multiregion_public_vpc
}

output "multiregion_public_vpc_subnet01" {
  value = google_compute_subnetwork.multiregion_subnetwork01
}

output "multiregion_public_vpc_subnet02" {
  value = google_compute_subnetwork.multiregion_subnetwork02
}