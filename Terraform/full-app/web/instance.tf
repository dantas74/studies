data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "this" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.ssh_cidr_block]
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = "this-key"
  public_key = file("id_rsa.pub")
}

resource "aws_launch_configuration" "this" {
  image_id        = data.aws_ami.latest_ubuntu.id
  instance_type   = var.instance_type
  user_data       = <<EOF
#!/bin/bash

apt update
apt install -y nginx
EOF
  security_groups = [aws_security_group.this.id]
  key_name        = aws_key_pair.this.key_name

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
}

resource "aws_autoscaling_group" "this" {
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.this.name
  vpc_zone_identifier       = module.vpc.pub_sub_ids
  target_group_arns         = [aws_lb_target_group.this.arn]
}
