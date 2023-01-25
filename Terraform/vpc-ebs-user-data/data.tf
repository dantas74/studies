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

data "template_file" "install_apache" {
  template = file("init.cfg")
}

data "template_cloudinit_config" "install_apache" {
  gzip          = false
  base64_encode = false

  part {
    filename     = file("init.cfg")
    content_type = "text/cloud-config"
    content      = data.template_file.install_apache.rendered
  }
}
