resource "aws_eip" "main_eip" {
  vpc = true
}

resource "aws_nat_gateway" "main_ngw" {
  allocation_id = aws_eip.main_eip.id
  subnet_id     = aws_subnet.pub_1.id
  depends_on    = [aws_internet_gateway.main_igw]
}

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main_ngw.id
  }

  tags = {
    "Name" = "main-NGW-RT"
  }
}

resource "aws_route_table_association" "main_association" {
  subnet_id      = aws_subnet.prv_1.id
  route_table_id = aws_route_table.nat_gateway.id
}

resource "aws_route_table_association" "main_association" {
  subnet_id      = aws_subnet.prv_2.id
  route_table_id = aws_route_table.nat_gateway.id
}

resource "aws_route_table_association" "main_association" {
  subnet_id      = aws_subnet.prv_3.id
  route_table_id = aws_route_table.nat_gateway.id
}
