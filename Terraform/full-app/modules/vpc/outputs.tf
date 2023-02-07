output "vpc_id" {
  value = aws_vpc.this.id
}

output "prv_sub_ids" {
  value = [for sub in aws_subnet.private : sub.id]
}

output "pub_sub_ids" {
  value = [for sub in aws_subnet.public : sub.id]
}
