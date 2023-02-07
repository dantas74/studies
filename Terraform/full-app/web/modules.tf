module "vpc" {
  source = "../modules/vpc"

  environment = var.environment
  aws_region  = var.aws_region
}

module "rds" {
  source = "../modules/rds"

  environment = var.environment
  aws_region  = var.aws_region
}
