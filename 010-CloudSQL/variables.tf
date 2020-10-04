# CloudSQL Instance Variables
variable "cloud_sql_version" {
  type    = string
  default = "MYSQL_5_7"
}

variable "cloud_sql_tier" {
  type    = string
  default = "db-f1-micro"
}

variable "cloud_sql_size" {
  type    = string
  default = "10"
}

# CloudSQL Database Variables
variable "cloud_sql_password" {
  type    = string
  default = "wordpress-password"
}