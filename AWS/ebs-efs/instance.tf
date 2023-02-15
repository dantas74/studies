provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "this" {
  public_key = file("id-rsa.pub")
  key_name   = "test-aws"
}

resource "aws_security_group" "this" {
  name = "test-aws"

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami                    = "ami-0cff7528fff583bf9a"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [aws_security_group.this.id]

  ebs_block_device {
    device_name = "/dev/xvdfa"
    volume_size = 30
    volume_type = "gp2"
    encrypted   = true
  }

  user_data = <<EOF
#!/bin/bash

sudo yum update
sudo yum install -y httpd

sudo systemctl start httpd
echo "
<!DOCTYPE html>
<html>
  <head>
    <title>Getting Started with AWS</title>
    <style>
      body {
        margin: 3rem;
        text-align: center;
        background: linear-gradient(-10deg, #f8b013, #f08a05);
        color: white;
        font-family: sans-serif;
        height: 100vh;
      }

      div {
        border-radius: 12px;
        background-color: #251f11;
        padding: 2rem;
        max-width: 50rem;
        margin: auto;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
      }

      h1 {
        font-size: 4rem;
      }

      p {
        font-size: 2rem;
      }
    </style>
  </head>
  <body>
    <div>
      <h1>Hello, World!</h1>
      <p>Time to master AWS</p>
    </div>
  </body>
<html>
" > /var/www/html/index.html
EOF
}
