# Rule to firewall
resource "google_compute_firewall" "common_rule" {
  name    = "common-rule"
  network = data.terraform_remote_state.network.outputs.vpc_public.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}