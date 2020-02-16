# URL Map
resource "google_compute_url_map" "listener_http" {
  provider        = google-beta
  name            = "ialejandro-listener-http-target-proxy"
  description     = "URL Map HTTP"
  default_service = google_compute_backend_service.backend.self_link

  host_rule {
    hosts        = ["ialejandro.test"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.backend.self_link

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.backend.self_link
    }
  }
}

# http proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  provider    = google-beta
  name        = "ialejandro-target-http"
  description = "target http"
  url_map     = google_compute_url_map.listener_http.self_link
}

# Create forwarder rule
resource "google_compute_global_forwarding_rule" "allow_http" {
  provider              = google-beta
  name                  = "ialejandro"
  target                = google_compute_target_http_proxy.http_proxy.self_link
  port_range            = "80"
  ip_version            = "IPV4"
  load_balancing_scheme = "EXTERNAL"
}
