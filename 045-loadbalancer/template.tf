# TEMPLATE
# Declaración de la template a usar por el IGM
resource "google_compute_instance_template" "webserver" {
  name        = "webserver-template"
  description = "Template de Webservers"

  // Lista de reglas firewall
  tags = ["${data.terraform_remote_state.vpc.outputs.firewall-common.name}"]

  instance_description = "webserver"
  machine_type         = "f1-micro"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Declaración de disco
  disk {
    source_image = data.google_compute_image.webserver.self_link
    disk_type    = "pd-standard"
    type         = "PERSISTENT"
    disk_size_gb = 10
    auto_delete  = true
    boot         = true
  }

  // VPC y subred
  network_interface {
    network    = data.terraform_remote_state.vpc.outputs.vpc.self_link
    subnetwork = data.terraform_remote_state.vpc.outputs.public-01.self_link

    // IP Publica
    access_config {
      network_tier = "STANDARD"
    }
  }
}