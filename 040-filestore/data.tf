data "terraform_remote_state" "dns" {
  backend = "gcs"

  config = {
    bucket      = "terraform-init-adrian"
    credentials = "../../../GCP/account_key/adrian_gcp.json"
    prefix      = "terraform-pro/dns"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket      = "terraform-init-adrian"
    credentials = "../../../GCP/account_key/adrian_gcp.json"
    prefix      = "terraform-pro/vpc"
  }
}