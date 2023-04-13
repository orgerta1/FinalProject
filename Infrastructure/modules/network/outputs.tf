output "main-vpc-id" {
  value = aws_vpc.main-vpc.id
}

output "subnet-ids" {
  value = [
    for subnet in aws_subnet.main-public-subnets : subnet.id
  ]
}