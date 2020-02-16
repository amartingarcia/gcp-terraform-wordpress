resource "google_compute_instance" "webserver" {
  name         = "instance-base-${random_id.db_name_suffix.hex}"
  description  = "instancia base para wordpress"
  machine_type = "f1-micro"
  zone         = "europe-west1-d"

  // Lista de reglas firewall
  tags = ["${data.terraform_remote_state.firewall.outputs.common-rule.name}"]

  boot_disk {
    auto_delete = false
    initialize_params {
      image = data.google_compute_image.debian.self_link
      type  = "pd-standard"
      size  = 10
    }
  }

  // VPC y subred
  network_interface {
    network    = data.terraform_remote_state.vpc.outputs.vpc_public.self_link
    subnetwork = data.terraform_remote_state.vpc.outputs.public_subnet01.self_link

    // IP Publica
    access_config {
      network_tier = "STANDARD"
    }
  }
}

resource "google_compute_instance" "webserver2" {
  name         = "instance-base-aaaa"
  description  = "instancia base para wordpress"
  machine_type = "f1-micro"
  zone         = "europe-west1-d"

  // Lista de reglas firewall
  tags = ["${data.terraform_remote_state.firewall.outputs.common-rule.name}"]

  boot_disk {
    auto_delete = false
    initialize_params {
      image = data.google_compute_image.debian.self_link
      type  = "pd-standard"
      size  = 10
    }
  }

  // VPC y subred
  network_interface {
    network    = data.terraform_remote_state.vpc.outputs.vpc_public.self_link
    subnetwork = data.terraform_remote_state.vpc.outputs.public_subnet01.self_link

    // IP Publica
    access_config {
      network_tier = "STANDARD"
    }
  }
}
