variable "path_to_public_key" {
  description = "The path leading to the public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vpc_id" {
  type        = string
  description = "The id of the VPC for the instance"
  default     = ""
}

variable "environment" {
  description = "The environment to create the VPC"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "The region in which VPC will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "amis" {
  description = "Map of AMIs for some regions"
  type        = map(string)
  default     = {
    "us-east-1" = "ami-1"
    "us-east-2" = "ami-2"
    "us-west-1" = "ami-3"
    "us-west-2" = "ami-4"
  }
}

variable "instance_type" {
  description = "The instance type for the instance"
  type        = string
  default     = "t3.micro"
}

variable "public_subnets" {
  description = "Public subnets of VPC"
  type        = list(string)
  default     = []
}
