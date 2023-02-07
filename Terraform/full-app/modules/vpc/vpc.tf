provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.pub_subnets_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.environment}-pub-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.prv_subnets_cidr[count.index]
  availability_zone = data.aws_availability_zones.available[count.index]

  tags = {
    "Name" = "${var.environment}-prv-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.environment}-igw"
  }
}

resource "aws_eip" "this" {
  vpc        = true
  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_eip.this]

  tags = {
    "Name" = "${var.environment}-ngw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    "Name" = "${var.environment}-pub-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    "Name" = "${var.environment}-prv-rt"
  }
}

resource "aws_route_table_association" "pub" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "prv" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.private.id
}
