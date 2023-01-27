data "aws_availability_zones" "this" {
  filter {
    name   = "region-name"
    values = [var.AWS_REGION]
  }
}
