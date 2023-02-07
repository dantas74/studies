module "this" {
  source = "web"

  aws_region  = var.aws_region
  environment = var.environment
}

provider "aws" {
  region = var.aws_region
}
