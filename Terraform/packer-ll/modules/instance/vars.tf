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

variable "ami_id" {
  description = "AMI for deploy"
  type        = string
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
