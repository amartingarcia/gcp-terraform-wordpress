# VPC Firewall Rules
## Common-rule
resource "google_compute_firewall" "common_rule" {
  name    = "common-rule-${terraform.workspace}"
  network = google_compute_network.public_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

## SSH rule
resource "google_compute_firewall" "ssh_rule" {
  name    = "ssh-rule-${terraform.workspace}"
  network = google_compute_network.public_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}