# CloudSQL Instance Variables
variable "cloud_sql_version" {
  default = "MYSQL_5_7"
}

variable "cloud_sql_tier" {
  default = "db-f1-micro"
}

variable "cloud_sql_size" {
  default = "10"
}

# CloudSQL Database Variables
variable "cloud_sql_database" {
  default = "wordpress"
}

# CloudSQL Users Variables
variable "cloud_sql_user" {
  default = "test"
}

variable "cloud_sql_host" {
  default = "%"
}

variable "cloud_sql_password" {
  default = "test1"
}