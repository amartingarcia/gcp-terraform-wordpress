# IGM
# Declaración del group manager (autoscaling)
resource "google_compute_instance_group_manager" "webservers" {
  name               = "webservers"
  description        = "IGM para servidores web"
  zone               = "europe-west1-d"
  base_instance_name = "webservers"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.webserver.self_link
  }
}