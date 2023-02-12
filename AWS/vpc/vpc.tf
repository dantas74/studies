provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false

  tags = {
    "Name" = "test-vpc"
  }
}

resource "aws_subnet" "pub_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "pub_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
}

resource "aws_subnet" "pub_3" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
}

resource "aws_subnet" "prv_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "prv_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
}

resource "aws_subnet" "prv_3" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "test-aws-igw"
  }
}

resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    "Name" = "test-aws-igw-rt"
  }
}

resource "aws_route_table_association" "pub_1" {
  subnet_id      = aws_subnet.pub_1.id
  route_table_id = aws_route_table.main_rt.id
}

resource "aws_route_table_association" "pub_2" {
  subnet_id      = aws_subnet.pub_2.id
  route_table_id = aws_route_table.main_rt.id
}

resource "aws_route_table_association" "pub_3" {
  subnet_id      = aws_subnet.pub_3.id
  route_table_id = aws_route_table.main_rt.id
}

