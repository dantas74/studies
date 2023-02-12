resource "aws_instance" "this" {
  ami           = "ami-0cff7528fff583bf9a"
  instance_type = "t2.micro"

  # The two ways here make the instance in a specific VPC
  vpc_security_group_ids = [aws_security_group.this.id]
  subnet_id              = aws_subnet.pub_1.id
}
