resource "aws_key_pair" "this" {
  key_name   = "master-kp"
  public_key = file(var.path_to_public_key)
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = element(var.public_subnets, 0)

  vpc_security_group_ids = [aws_security_group.this.id]

  key_name = aws_key_pair.this.key_name

  tags = {
    "Name"        = "instance-${var.environment}"
    "Environment" = var.environment
  }
}
