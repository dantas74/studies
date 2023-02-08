resource "aws_key_pair" "this" {
  key_name   = "elk-key"
  public_key = file("id_rsa.pub")
}

resource "aws_instance" "this" {
  ami               = lookup(var.amis, var.aws_region)
  instance_type     = "m4.large"
  availability_zone = data.aws_availability_zones.this.names[0]
  key_name          = aws_key_pair.this.key_name

  vpc_security_group_ids = [aws_security_group.this.id]

  depends_on = [aws_security_group.this]

  provisioner "file" {
    source      = "files/elasticsearch.yml"
    destination = "/tmp/elasticsearch.yml"
  }

  provisioner "file" {
    source      = "files/kibana.yml"
    destination = "/tmp/kibana.yml"
  }

  provisioner "file" {
    source      = "files/apache-01.conf"
    destination = "/tmp/apache-01.conf"
  }

  provisioner "file" {
    source      = "files/install-elk.sh"
    destination = "/tmp/install-elk.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install-elk.sh",
      "sudo /tmp/install-elk.sh"
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("id_rsa")
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}
