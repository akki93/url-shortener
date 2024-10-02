###################
# Dev VPC
###################
resource "aws_vpc" "dev_vpc" {
  cidr_block       = "10.1.0.0/20"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "app-public-${each.key}"
    Tier = "public"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = each.value
  map_public_ip_on_launch = false

  tags = {
    Name = "app-private-${each.key}"
    Tier = "private"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "app_public_rtb"
    Tier = "public"
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "app-private-rtb"
    Tier = "private"
  }
}

resource "aws_route_table_association" "public_rtb_assoc" {
  depends_on     = [aws_subnet.public_subnet]
  route_table_id = aws_route_table.public_rtb.id
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "pvt_rtb_assoc" {
  depends_on     = [aws_subnet.private_subnet]
  route_table_id = aws_route_table.private_rtb.id
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "app-igw"
  }
}

resource "aws_eip" "gateway_eip" {
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "app-nat-gw-eip"
  }
}

#resource "aws_nat_gateway" "nat_gateway" {
#  depends_on    = [aws_subnet.public_subnet]
#  allocation_id = aws_eip.nat_gateway_eip.id
#  subnet_id     = aws_subnet.public_subnet["subnet-01"].id
#  tags = {
#    Name = "terraform-nat-gw"
#  }
#}

###################
# Security Group
###################
resource "aws_security_group" "app_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = aws_vpc.dev_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

###################
# Prod VPC
###################
resource "aws_vpc" "prod_vpc" {
  cidr_block       = "10.3.0.0/20"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = "prod"
  }
}
