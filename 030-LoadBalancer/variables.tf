# Variables
##
variable "gcp_rsa_user" {
  type    = string
  default = "example"
}

##
variable "gcp_rsa_path" {
  type    = string
  default = "/example/example_rsa"
}

##
variable "wp_version" {
  type    = string
  default = "5.3"
}

##
variable "servername" {
  type    = string
  default = "example.com"
}

##
variable "serveradmin" {
  type    = string
  default = "example@gexample.com"
}

## Instance Template Variables
variable "wordpress_template_type" {
  type    = string
  default = "f1-micro"
}


## Instance Template Variables
variable "filestore_capacity" {
  type    = number
  default = 1024
}