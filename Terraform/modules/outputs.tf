output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.this.id
}

output "sg_ids" {
  value = [
    aws_security_group.this.id
  ]
}
