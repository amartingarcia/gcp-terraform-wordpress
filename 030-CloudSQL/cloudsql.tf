# Create private IP
resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-cloudsql-${random_id.db_name_suffix.hex}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.terraform_remote_state.vpc.outputs.vpc_public.self_link
}

# Create connection IP with Private Networks
resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network = data.terraform_remote_state.vpc.outputs.vpc_public.self_link
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = []
  #reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# Generate random suffix
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# CloudSQL Database Instance
resource "google_sql_database_instance" "wordpress_instance" {
  provider = google-beta

  name             = "wordpress-cloudsql-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = var.cloud_sql_version

  settings {
    tier      = var.cloud_sql_tier
    disk_size = var.cloud_sql_size
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.terraform_remote_state.vpc.outputs.vpc_public.self_link
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

# CloudSQL Database to instance
resource "google_sql_database" "wordpress_database" {
  name     = var.cloud_sql_database
  instance = google_sql_database_instance.wordpress_instance.name

  depends_on = [google_sql_database_instance.wordpress_instance]
}

# CloudSQL Users
resource "google_sql_user" "wordpress_users" {
  name     = var.cloud_sql_user
  instance = google_sql_database_instance.wordpress_instance.name
  host     = var.cloud_sql_host
  password = var.cloud_sql_password

  depends_on = [google_sql_database_instance.wordpress_instance]
}