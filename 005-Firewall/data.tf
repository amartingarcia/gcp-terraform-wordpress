data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket      = "terraform-init-adrian"
    credentials = "../../../GCP/account_key/adrian_gcp.json"
    prefix      = "terraform-pro/vpc"
  }
}