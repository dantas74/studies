resource "aws_key_pair" "main" {
  key_name   = "terraform-key"
  public_key = "id_rsa.pub"
}

resource "aws_instance" "main" {
  ami               = data.aws_ami.latest_ubuntu
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.main.key_name
  availability_zone = data.aws_availability_zone.available[1]

  provisioner "file" {
    source      = "install-nginx.sh"
    destination = "/tmp/install-nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-nginx.sh",
      "sudo sed -i -e 's/\r$//' /tmp/install-nginx.sh",
      "sudo /tmp/install-nginx.sh"
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ubuntu"
    private_key = "id_rsa.pem"
  }

  tags = {
    "Name" = "terraform"
  }
}
