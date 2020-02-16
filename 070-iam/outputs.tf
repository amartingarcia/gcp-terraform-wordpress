output "service_account" {
  value = google_service_account.object_viewer
}

output "audit_log" {
  value = google_project_iam_audit_config.project
}