# Terraform config
## GCP Provider
provider "google" {
  credentials = "../../elite-droplet-259420-1347608aa526.json"
  project     = var.project
  region      = var.region
}

## GCP Beta Provider
provider "google-beta" {
  credentials = "../../elite-droplet-259420-1347608aa526.json"
  project     = var.project
  region      = var.region
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
  required_version = ">= 0.13"
}
