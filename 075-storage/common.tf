# Global Variables
variable "path_key" {
  default = "/Users/adrian/Documents/repository/GCP/account_key/adrian_gcp.json"
}

# Default region
variable "region" {
  default = "europe-west1"
}

# Select environment Example: var.environment.0
variable "environment" {
  type    = list(string)
  default = ["dev", "pre", "pro"]
}

# Default projectr
variable "project" {
  default = "elite-droplet-259420"
}