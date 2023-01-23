resource "aws_instance" "main" {
  count         = 3
  ami           = "ami-087ac3ad37e2a1138"
  instance_type = "t2.micro"

  tags = {
    "Name" = "terraform-${count.index}"
  }
}
