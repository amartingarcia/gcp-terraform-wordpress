provider "google" {
  credentials = "../../../../GCP/account_key/adrian_gcp.json"
  project     = var.project
  region      = var.region
}

provider "google-beta" {
  credentials = "../../../../GCP/account_key/adrian_gcp.json"
  project     = var.project
  region      = var.region
}