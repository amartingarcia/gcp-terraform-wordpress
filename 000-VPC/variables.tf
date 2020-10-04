# VPC Variables
## CIDR Private network
variable "private_cidr_network" {
  type    = string
  default = "10.2.0.0/16"
}

## Secondary CIDR
variable "private_cidr_network_secondary" {
  type    = string
  default = "192.168.10.0/24"
}

## CIDR Public network
variable "public_cidr_network" {
  type    = string
  default = "10.3.0.0/16"
}