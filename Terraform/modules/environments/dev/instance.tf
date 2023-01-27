resource "aws_key_pair" "this" {
  public_key = file("id_rsa")
  key_name   = "this-kp"
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = module.dev_vpc.sg_ids

  tags = {
    "Environment" = var.environment
  }
}
