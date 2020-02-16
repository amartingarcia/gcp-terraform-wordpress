# VPC Network Private
resource "google_compute_network" "vpc_dev_private" {
  name                    = "private-vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet01_private_vpc" {
  name                     = "private-subnet"
  ip_cidr_range            = "10.2.0.0/16"
  region                   = var.region
  network                  = google_compute_network.vpc_dev_private.self_link
  private_ip_google_access = "true"
  secondary_ip_range {
    range_name    = "secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

# VPC Network Public
resource "google_compute_network" "vpc_dev_public" {
  name                    = "public-vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet01_public_vpc" {
  name          = "public-subnet"
  ip_cidr_range = "10.3.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_dev_public.self_link
}

# VPC Network with subnets in distinct region
resource "google_compute_network" "multiregion_public_vpc" {
  name                    = "multiregion-vpc-adrian"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "multiregion_subnetwork01" {
  name          = "subnet-public01"
  ip_cidr_range = "10.3.0.0/16"
  region        = var.region
  network       = google_compute_network.multiregion_public_vpc.self_link
}

resource "google_compute_subnetwork" "multiregion_subnetwork02" {
  name          = "subnet-public02"
  ip_cidr_range = "10.4.0.0/16"
  region        = "europe-west3"
  network       = google_compute_network.multiregion_public_vpc.self_link
}