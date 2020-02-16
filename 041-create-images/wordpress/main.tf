resource "google_compute_instance" "webserver" {
  name         = "wordpress-base"
  description  = "instancia base para wordpress"
  machine_type = "f1-micro"
  zone         = "europe-west1-d"

tags = ["${data.terraform_remote_state.firewall.outputs.common-rule.name}"]

  boot_disk {
    auto_delete = false
    initialize_params {
      image = data.google_compute_image.debian.self_link
      type  = "pd-standard"
      size  = 10
    }
  }

  network_interface {
    network    = data.terraform_remote_state.vpc.outputs.vpc_public.self_link
    subnetwork = data.terraform_remote_state.vpc.outputs.public_subnet01.self_link

    access_config {
      network_tier = "STANDARD"
    }
  }

  provisioner "local-exec" {
    working_dir = "ansible"

    command = <<EOF
ANSIBLE_SSH_ARGS='-o IdentitiesOnly=yes' ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${google_compute_instance.webserver.network_interface.0.access_config.0.nat_ip},' \
-u ialejandro --private-key ~/.ssh/id_rsa --extra-vars "tf_env_instance=${google_compute_instance.webserver.name} tf_env_zone=${google_compute_instance.webserver.zone} tf_env_project=${google_compute_instance.webserver.project}" \
main.yml
EOF
  }
}