resource "aws_network_acl" "this" {
  vpc_id = aws_vpc.this.id

  ingress {
    action    = "Allow"
    from_port = 0
    protocol  = "-1"
    rule_no   = 100
    to_port   = 0
  }

  egress {
    action    = "Allow"
    from_port = 0
    protocol  = "-1"
    rule_no   = 100
    to_port   = 0
  }
}

resource "aws_network_acl_association" "pub_1" {
  network_acl_id = aws_network_acl.this.id
  subnet_id      = aws_subnet.pub_1.id
}

resource "aws_network_acl_association" "pub_2" {
  network_acl_id = aws_network_acl.this.id
  subnet_id      = aws_subnet.pub_2.id
}

resource "aws_network_acl_association" "pub_3" {
  network_acl_id = aws_network_acl.this.id
  subnet_id      = aws_subnet.pub_3.id
}

resource "aws_network_acl_association" "prv_1" {
  network_acl_id = aws_network_acl.this.id
  subnet_id      = aws_subnet.prv_1.id
}

resource "aws_network_acl_association" "prv_2" {
  network_acl_id = aws_network_acl.this.id
  subnet_id      = aws_subnet.prv_2.id
}

resource "aws_network_acl_association" "prv_3" {
  network_acl_id = aws_network_acl.this.id
  subnet_id      = aws_subnet.prv_3.id
}
