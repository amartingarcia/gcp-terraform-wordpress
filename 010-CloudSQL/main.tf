# CloudSQL
## Generate random suffix
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

## CloudSQL Database Instance
resource "google_sql_database_instance" "wordpress_instance" {
  provider = google-beta

  name             = "wordpress-cloudsql-${terraform.workspace}-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = var.cloud_sql_version

  settings {
    tier      = var.cloud_sql_tier
    disk_size = var.cloud_sql_size
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.terraform_remote_state.vpc.outputs.public_vpc.self_link
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

## Private IP to CloudSQL
resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-cloudsql-${terraform.workspace}-${random_id.db_name_suffix.hex}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.terraform_remote_state.vpc.outputs.public_vpc.self_link
}

## Connection IP with Private Networks
resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = data.terraform_remote_state.vpc.outputs.public_vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  #reserved_peering_ranges = []
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_compute_global_address.private_ip_address]
}

## Database into CloudSQL instance
resource "google_sql_database" "wordpress_database" {
  name     = "wordpress-${terraform.workspace}"
  instance = google_sql_database_instance.wordpress_instance.name

  depends_on = [google_sql_database_instance.wordpress_instance]
}

## CloudSQL User
resource "google_sql_user" "wordpress_user" {
  name     = "wordpress-${terraform.workspace}"
  instance = google_sql_database_instance.wordpress_instance.name
  host     = "%"
  password = var.cloud_sql_password

  depends_on = [google_sql_database_instance.wordpress_instance]
}