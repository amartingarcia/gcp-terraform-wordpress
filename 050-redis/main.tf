resource "google_redis_instance" "cache" {
  name           = "redis-${var.environment.0}"
  tier           = var.redis_tier
  memory_size_gb = var.redis_size

  project = var.project
  region = var.region

  authorized_network = data.terraform_remote_state.vpc.outputs.vpc_private.self_link

  redis_version = var.redis_version
  display_name  = "Redis Instance"
  #reserved_ip_range = "192.168.0.0/29"

  labels = {
    environment = var.environment.0
  }
}