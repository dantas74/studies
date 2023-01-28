module "this_vpc" {
  source = "./modules/vpc"

  environment = var.ENVIRONMENT
  aws_region  = var.AWS_REGION
}

module "this_instance" {
  source = "./modules/instance"

  environment    = var.ENVIRONMENT
  ami_id         = ""
  vpc_id         = module.this_vpc.vpc_id
  public_subnets = module.this_vpc.public_subnets
}
