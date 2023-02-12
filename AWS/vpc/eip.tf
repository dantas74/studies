resource "aws_eip" "this" {
  vpc = aws_vpc.this.id
}

resource "aws_eip_association" "this" {
  public_ip   = aws_eip.this.public_ip
  instance_id = aws_instance.this.id
}
