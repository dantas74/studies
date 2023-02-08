variable "aws_region" {}

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
