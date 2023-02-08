resource "aws_security_group" "this" {
  ingress {
    from_port   = 9200
    protocol    = "tcp"
    to_port     = 9200
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5043
    protocol    = "tcp"
    to_port     = 5043
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5601
    protocol    = "tcp"
    to_port     = 5601
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
}
