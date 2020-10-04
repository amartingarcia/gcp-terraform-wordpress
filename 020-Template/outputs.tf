# Template outputs
## Private IP
output "image_wordpress_template" {
  value = google_compute_instance.wordpress.name
}
