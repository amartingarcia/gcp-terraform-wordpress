# Remote Backend
terraform {
  backend "gcs" {
    bucket      = "terraform-amartingarcia"
    credentials = "../../elite-droplet-259420-1347608aa526.json"
    prefix      = "template"
  }
}