provider "aws" {
  region = "us-east-2"
  
  default_tags {
    Project    = "testes-eks"
    Maintainer = "matheus-dr"
  }
}
