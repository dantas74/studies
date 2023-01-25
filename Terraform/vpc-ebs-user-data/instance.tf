resource "aws_key_pair" "main" {
  key_name   = "terraform-key"
  public_key = "id_rsa.pub"
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.latest_ubuntu
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name

  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.pub_1.id

  ## Cloud init User Data
  user_data = data.template_cloudinit_config.install_apache.rendered

  ## Scripted User Data
  #  user_data = <<EOF
  #!/bin/bash
  #apt update
  #apt install -y apache2
  #systemctl start apache2
  #systemctl enable apache2
  #echo "<h1>Deployed from terraform</h1>" | sudo tee /var/www/html/index.html
  #EOF

  tags = {
    "Name" = "terraform"
  }
}
