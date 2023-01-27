module "dev_vpc" {
  source = "../../../modules"

  vpc_name                       = "dev01-vpc"
  cidr                           = "10.0.0.0/16"
  enable_dns_support             = true
  enable_classiclink             = false
  enable_classiclink_dns_support = false
  enable_ipv6                    = true
  environment                    = var.environment
  availability_zone              = "us-east-1a"
  subnet_cidr                    = "10.0.1.0/24"
}
