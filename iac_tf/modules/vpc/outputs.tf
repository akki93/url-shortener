output "private_subnet" {
  value = [for subnet in aws_subnet.private_subnet: subnet.id]
}

output "sg_id" {
  value = aws_security_group.app_sg.id
}