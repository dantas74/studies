variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "pub_subnets_cidr" {
  type    = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "prv_subnets_cidr" {
  type    = list(string)
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}
