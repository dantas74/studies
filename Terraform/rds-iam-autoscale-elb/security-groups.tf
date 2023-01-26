resource "aws_security_group" "main" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "Allow SSH connection"

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.main_elb.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "allow-ssh"
  }
}

resource "aws_security_group" "mariadb" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-mariadb"
  description = "Allow MariaDB connection"

  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.main.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "allow-ssh"
  }
}

resource "aws_security_group" "main_elb" {
  vpc_id = aws_vpc.main.id
  name   = "main-elb-sg"

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
}
