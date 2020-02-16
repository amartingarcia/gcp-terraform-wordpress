# Redis Variables
variable "redis_tier" {
  default = "STANDARD_HA"
}

variable "redis_size" {
  default = "1"
}

variable "redis_version" {
  default = "REDIS_3_2"
}