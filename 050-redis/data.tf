data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket      = "terraform-init-adrian"
    credentials = "../../../GCP/account_key/adrian_gcp.json"
    prefix      = "init/network.tfstate"
  }
}