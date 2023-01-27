module "prod_vpc" {
  source = "../modules/vpc"

  environment = var.ENVIRONMENT
  aws_region  = var.AWS_REGION
}

module "prod_instances" {
  source = "../modules/instance"

  environment    = var.ENVIRONMENT
  aws_region     = var.AWS_REGION
  vpc_id         = module.prod_vpc.vpc_id
  public_subnets = module.prod_vpc.public_subnets
}
