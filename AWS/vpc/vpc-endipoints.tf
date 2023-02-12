# This creates a Private Link, that Amazon will send request to it's services via it's private network

resource "aws_vpc_endpoint" "this" {
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_id       = aws_vpc.this.id
}
