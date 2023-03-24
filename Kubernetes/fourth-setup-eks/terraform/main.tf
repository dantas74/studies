provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = "testes-eks"
      Maintainer = "matheus-dr"
    }
  }
}
