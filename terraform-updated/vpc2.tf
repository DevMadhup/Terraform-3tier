#######################################
# VPC2
#######################################
resource "aws_vpc" "vpc2" {
  cidr_block           = var.vpc2_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC2"
  }
}

#######################################
# Route Table (Private)
#######################################
resource "aws_route_table" "vpc2_private_rt" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "VPC2-Private-RouteTable"
  }
}

#######################################
# Route Table Associations
#######################################
resource "aws_route_table_association" "vpc2_private_1_assoc" {
  subnet_id      = aws_subnet.vpc2_private_1.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}

resource "aws_route_table_association" "vpc2_private_2_assoc" {
  subnet_id      = aws_subnet.vpc2_private_2.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}

