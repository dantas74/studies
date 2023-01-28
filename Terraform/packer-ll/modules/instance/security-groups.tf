resource "aws_security_group" "this" {
  vpc_id      = var.vpc_id
  name        = "master-ssh-sg-${var.environment}"
  description = "Allows SSH connection for the ${var.environment} environment"

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"        = "master-ssh-sg-${var.environment}"
    "Environment" = var.environment
  }
}
