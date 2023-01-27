variable "AWS_REGION" {
  default = "us-east-1"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_classiclink" {
  type    = bool
  default = false
}

variable "enable_classiclink_dns_support" {
  type    = bool
  default = false
}

variable "enable_ipv6" {
  type    = bool
  default = false
}

variable "vpc_name" {}

variable "environment" {}


variable "subnet_cidr" {}

variable "availability_zone" {}
