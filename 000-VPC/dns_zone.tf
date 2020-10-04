# DNS
## Public Zone
resource "google_dns_managed_zone" "public_zone" {
  name        = "public-zone-${terraform.workspace}"
  dns_name    = "public-${terraform.workspace}-zone.example."
  description = "Public DNS zone"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.public_vpc.self_link
    }
  }

}

## Private Zone
resource "google_dns_managed_zone" "private_zone" {
  name        = "private-zone-${terraform.workspace}"
  dns_name    = "private-${terraform.workspace}-zone.example."
  description = "Private DNS zone"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.private_vpc.self_link
    }
  }
}

resource "random_id" "random" {
  byte_length = 4
}