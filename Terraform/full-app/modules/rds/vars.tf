variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "rds_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "allocated_storage" {
  type = number
}

variable "rds_engine" {
  type = string
}

variable "rds_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "backup_retention_period" {
  type = bool
}

variable "publicly_accessible" {
  type = bool
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}
