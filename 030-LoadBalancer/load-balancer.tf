# GCP Resources
## Backend Service
resource "google_compute_backend_service" "wordpress" {
  provider = google-beta

  name        = "backend-service-${terraform.workspace}"
  description = "backend service environment ${terraform.workspace}"

  connection_draining_timeout_sec = 100
  port_name                       = "http"
  protocol                        = "HTTP"
  timeout_sec                     = 10
  load_balancing_scheme           = "EXTERNAL"

  backend {
    balancing_mode        = "UTILIZATION"
    group                 = google_compute_instance_group_manager.wordpress.instance_group
    max_rate_per_instance = 1
  }

  health_checks = [google_compute_health_check.health_check.self_link]

}

## Health Check
resource "google_compute_health_check" "health_check" {
  provider = google-beta

  name               = "health-check-${terraform.workspace}"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "80"
  }

}

## Template
resource "google_compute_instance_template" "wordpress" {

  name        = "wordpress-template-${terraform.workspace}"
  description = "Template de wordpress"

  tags = [data.terraform_remote_state.vpc.outputs.common_firewall_rule.name]

  instance_description = "wordpress"
  machine_type         = "f1-micro"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = data.google_compute_image.wordpress.self_link
    disk_type    = "pd-standard"
    type         = "PERSISTENT"
    disk_size_gb = 10
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = data.terraform_remote_state.vpc.outputs.public_vpc.self_link
    subnetwork = data.terraform_remote_state.vpc.outputs.public_subnet.self_link

    access_config {
      network_tier = "STANDARD"
    }
  }

}

## Listener
resource "google_compute_url_map" "listener_http" {
  provider = google-beta

  name            = "listener-http-target-proxy-${terraform.workspace}"
  description     = "URL Map HTTP"
  default_service = google_compute_backend_service.wordpress.self_link

}

## HTTP Proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  provider = google-beta

  name        = "target-http-${terraform.workspace}"
  description = "target http"
  url_map     = google_compute_url_map.listener_http.self_link

}

## Forwarder rule
resource "google_compute_global_forwarding_rule" "allow_http" {
  provider = google-beta

  name                  = "allow-http-${terraform.workspace}"
  target                = google_compute_target_http_proxy.http_proxy.self_link
  port_range            = "80"
  ip_version            = "IPV4"
  load_balancing_scheme = "EXTERNAL"

}

## Group Manager
resource "google_compute_instance_group_manager" "wordpress" {
  name               = "wordpress-${terraform.workspace}"
  description        = "IGM para servidores web"
  zone               = "europe-west1-d"
  base_instance_name = "wordpress"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.wordpress.self_link
  }

}
