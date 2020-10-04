# CloudSQL Outputs
## Private IP
output "cloudsql_private_ip_address" {
  value = google_compute_global_address.private_ip_address.address
}

## CloudSQL Database Instance
output "cloudsql_wordpress_instance" {
  value = google_sql_database_instance.wordpress_instance.name
}

## CloudSQL Database to instance
output "cloudsql_wordpress_database" {
  value = google_sql_database.wordpress_database.name
}

## CloudSQL Sensitive password
output "cloudsql_wordpress_user_password" {
  value     = google_sql_user.wordpress_user.password
  sensitive = true
}

## CloudSQL Users
output "cloudsql_wordpress_user_name" {
  value = google_sql_user.wordpress_user.name
}

## CloudSQL DNS Records
output "cloudsql_wordpress_sql_record" {
  value = google_dns_record_set.wordpres_sql_record.name
}

