resource "google_project_iam_audit_config" "project" {
  project = var.project
  service = "monitoring.googleapis.com"
  count = length(var.log_type)
  audit_log_config {
    log_type = element(var.log_type, count.index)
    exempted_members = var.members_list
  }
}