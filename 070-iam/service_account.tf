resource "google_service_account" "object_viewer" {
  account_id   = "object-viewer"
  display_name = "Object viewer"
  description = "Credenciales para Viewer"
  project = var.project
}