# VPC
## VPC Private Network
resource "google_compute_network" "private_vpc" {
  name                    = "private-vpc-${terraform.workspace}"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "private_subnet" {
  name                     = "private-subnet--${terraform.workspace}"
  ip_cidr_range            = var.private_cidr_network
  region                   = var.region
  network                  = google_compute_network.private_vpc.self_link
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = "secondary-range-${terraform.workspace}"
    ip_cidr_range = var.private_cidr_network_secondary
  }
}

## VPC Public Network
resource "google_compute_network" "public_vpc" {
  name                    = "public-vpc-${terraform.workspace}"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet-${terraform.workspace}"
  ip_cidr_range = var.public_cidr_network
  region        = var.region
  network       = google_compute_network.public_vpc.self_link
}