output "ec2_url" {
  value = aws_instance.web.public_dns
}