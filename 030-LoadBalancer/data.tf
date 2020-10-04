# Data Sources
## Network
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket      = "terraform-amartingarcia"
    credentials = "../../elite-droplet-259420-1347608aa526.json"
    prefix      = "vpc"
  }

  workspace = terraform.workspace
}

## Network
data "terraform_remote_state" "template" {
  backend = "gcs"

  config = {
    bucket      = "terraform-amartingarcia"
    credentials = "../../elite-droplet-259420-1347608aa526.json"
    prefix      = "template"
  }

  workspace = terraform.workspace
}

## Image Data Source
data "google_compute_image" "debian" {
  family  = "debian-10"
  project = "debian-cloud"
}

## Image Data Source
data "google_compute_image" "wordpress" {
  name = data.terraform_remote_state.template.outputs.image_wordpress_template
}