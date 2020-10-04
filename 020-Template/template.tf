# Resources
resource "google_compute_instance" "wordpress" {
  name         = "wordpress-template"
  description  = "Wordpress Template"
  machine_type = "f1-micro"
  zone         = var.zone

  tags = [data.terraform_remote_state.vpc.outputs.common_firewall_rule.name]

  boot_disk {
    auto_delete = false
    initialize_params {
      image = data.google_compute_image.debian.self_link
      type  = "pd-standard"
      size  = 10
    }
  }

  network_interface {
    network    = data.terraform_remote_state.vpc.outputs.public_vpc.self_link
    subnetwork = data.terraform_remote_state.vpc.outputs.public_subnet.self_link

    access_config {
      network_tier = "STANDARD"
    }
  }

  provisioner "local-exec" {
    working_dir = "ansible"

    command = <<EOF
    ANSIBLE_SSH_ARGS='-o IdentitiesOnly=yes' ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i \
      '${google_compute_instance.wordpress.network_interface.0.access_config.0.nat_ip},' \
      -u ${var.gcp_rsa_user} \
      --private-key ${var.gcp_rsa_path} \
      --extra-vars "tf_env_instance=${google_compute_instance.wordpress.name} \
                    tf_env_zone=${google_compute_instance.wordpress.zone} \
                    tf_env_project=${google_compute_instance.wordpress.project} \
                    gcp_zone=${var.zone} \
                    gcp_project=${var.project} \
                    gcp_cred_file=${var.key_path} \
                    image_name=${google_compute_instance.wordpress.name} \
                    mountpoint=${google_filestore_instance.wordpress.networks[0].ip_addresses[0]}:/${google_filestore_instance.wordpress.file_shares[0].name} \
                    wp_version=${var.wp_version} \
                    servername=${var.servername} \
                    serveradmin=${var.serveradmin}" \
      main.yml
EOF
  }

}
