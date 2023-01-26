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

  iam_instance_profile = aws_iam_instance_profile.matheus_dr_access_instance_profile.name

  tags = {
    "Name" = "terraform"
  }
}
