
variable "env" {
  type    = string
  default = "prd"
}

variable "vpc_name" {
  type    = string
  default = "mateus-tf"
}

variable "pub_subnet_1a_name" {
  type    = string
  default = "terraform-public-subnet-1a"
}

variable "pub_subnet_1c_name" {
  type    = string
  default = "terraform-public-subnet-1c"
}

variable "priv_subnet_1a_name" {
  type    = string
  default = "terraform-private-subnet-1a"
}

variable "priv_subnet_1c_name" {
  type    = string
  default = "terraform-private-subnet-1c"
}

variable "ssh_allowed_cidr" {
  description = "IP autorizado a acessar a EC2 via SSH"
  type        = string
}
