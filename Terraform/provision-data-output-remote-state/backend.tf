terraform {
  backend "s3" {
    bucket = "matheus-dr-infra-state"
    key    = "development/terraform.tfstate"
    region = "us-east-1"
  }
}
