resource "aws_security_group" "us_east_sg" {
  name = "terraform-SG"

  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = data.aws_ip_ranges.us_east_ip_range.cidr_blocks
  }

  tags = {
    "Creation Date" = data.aws_ip_ranges.us_east_ip_range.create_date
    "Sync Token"    = data.aws_ip_ranges.us_east_ip_range.sync_token
  }
}
