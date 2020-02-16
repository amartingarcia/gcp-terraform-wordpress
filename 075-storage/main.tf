resource "google_storage_bucket" "image-store" {
  name     = "gcp-adrian-test1"
  force_destroy = "false"
  storage_class = var.storage_type.0

  location = var.storage_location.0
  project = var.project

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}