terraform {
  backend "gcs" {
    bucket      = "terraform-init-adrian"
    credentials = "../../../GCP/account_key/adrian_gcp.json"
    prefix      = "terraform-pro/storage"
  }
}