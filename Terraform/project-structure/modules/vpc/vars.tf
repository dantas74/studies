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
