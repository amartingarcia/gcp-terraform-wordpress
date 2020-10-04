# Filestore resources
resource "google_filestore_instance" "wordpress" {
  name = "wordpress-${terraform.workspace}"
  zone = var.zone
  tier = "STANDARD"

  file_shares {
    capacity_gb = var.filestore_capacity
    name        = "wordpress"
  }

  networks {
    network = data.terraform_remote_state.vpc.outputs.public_vpc.name
    modes   = ["MODE_IPV4"]
  }
}