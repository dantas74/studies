resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = "another-vpc-id"
  vpc_id      = aws_vpc.this.id
  peer_region = "us-east-1"
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

# If you want to connect multiple VPCs create a Transit Gateway
