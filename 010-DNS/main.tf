# Public Zone
resource "google_dns_managed_zone" "public_zone" {
  name        = "adrian-public"
  dns_name    = "adrian.public-${random_id.random.hex}.com."
  description = "Example public DNS zone"

  visibility = "private"

  labels = {
    environment = "dev"
    type        = "public"
  }

}

# Private Zone
resource "google_dns_managed_zone" "private_zone" {
  name        = "adrian-private"
  dns_name    = "adrian.private-${random_id.random.hex}.com."
  description = "Example private DNS zone"
  labels = {
    environment = "dev"
    type        = "private"
  }

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = data.terraform_remote_state.vpc.outputs.vpc_private.self_link
    }
  }
}

resource "random_id" "random" {
  byte_length = 4
}