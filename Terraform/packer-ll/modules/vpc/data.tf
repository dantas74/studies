data "aws_availability_zones" "this" {
  filter {
    name   = "region-name"
    values = [var.aws_region]
  }
}
