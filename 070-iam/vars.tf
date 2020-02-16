variable "log_type" {
  type    = list(string)
  default = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
}

variable "members_list" {
  type    = list(string)
  default = ["user:user@gmail.com", "user:user2@gmail.com"]
}