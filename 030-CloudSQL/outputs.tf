# Private IP
output "cloudsql_private_ip_address" {
  value = google_compute_global_address.private_ip_address
}

# Private connection
output "cloudsql_private_vpc_connection" {
  value = google_service_networking_connection.private_vpc_connection
}

# CloudSQL Database Instance
output "cloudsql_wordpress_instance" {
  value = google_sql_database_instance.wordpress_instance
}

# CloudSQL Database to instance
output "cloudsql_wordpress_database" {
  value = google_sql_database.wordpress_database
}

# CloudSQL Users
output "cloudsql_wordpress_users" {
  value = google_sql_user.wordpress_users
}

# CloudSQL DNS Records
output "cloudsql_wordpres_sql_record" {
  value = google_dns_record_set.wordpres_sql_record
}