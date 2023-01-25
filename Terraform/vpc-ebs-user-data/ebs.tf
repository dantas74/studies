resource "aws_ebs_volume" "secondary" {
  availability_zone = "us-east-1a"
  size              = 50
  type              = "gp2"

  tags = {
    "Name" = "Secondary EBS Volume"
  }
}

resource "aws_volume_attachment" "main_secondary" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.main.id
  volume_id   = aws_ebs_volume.secondary.id

  connection {
    host        = coalesce(aws_instance.main.public_ip, aws_instance.main.private_ip)
    type        = "ssh"
    user        = "ubuntu"
    private_key = "id_rsa.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/xvdh",
      "mkdir -p /data",
      "sudo mount /dev/xvdh /data",
      "echo '/dev/xvdh /data ext4 defaults 0 0' | sudo tee -a /etc/fstab"
    ]
  }
}
