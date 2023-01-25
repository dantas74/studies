variable "AWS_PROFILE" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "ami_ids" {
  type = map(string)

  default = {
    "us-east-1" : "ami-087ac3ad37e2a1138",
    "us-east-2" : "ami-0eceb7ed099f92fda"
  }
}
