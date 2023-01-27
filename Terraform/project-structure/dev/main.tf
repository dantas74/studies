module "dev_vpc" {
  source = "../modules/vpc"

  environment = var.ENVIRONMENT
  aws_region  = var.AWS_REGION
}

module "dev_instances" {
  source = "../modules/instance"

  environment    = var.ENVIRONMENT
  aws_region     = var.AWS_REGION
  vpc_id         = module.dev_vpc.vpc_id
  public_subnets = module.dev_vpc.public_subnets
}
