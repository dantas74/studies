resource "aws_instance" "main" {
  ami           = lookup(var.ami_ids, var.AWS_REGION)
  instance_type = "t2.micro"

  security_groups = var.security_groups

  tags = {
    "Name" = "terraform"
  }
}
