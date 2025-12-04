#############################
# VPC1
#############################
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc1_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC1"
  }
}

#############################
# VPC1 Public Subnet (AZ1)
#############################
resource "aws_subnet" "vpc1_public" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.vpc1_public_cidr
  availability_zone       = var.az1               
  map_public_ip_on_launch = true

  tags = {
    Name = "VPC1-Public-Subnet"
  }
}

#############################
# VPC1 Private Subnet (AZ2)
#############################
resource "aws_subnet" "vpc1_private" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.vpc1_private_cidr
  availability_zone = var.az2                  

  tags = {
    Name = "VPC1-Private-Subnet"
  }
}

#############################
# Internet Gateway
#############################
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "VPC1-IGW"
  }
}

#############################
# Public Route Table
#############################
resource "aws_route_table" "vpc1_public_rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "VPC1-Public-RT"
  }
}

#############################
# Public Route Table Association
#############################
resource "aws_route_table_association" "vpc1_public_assoc" {
  subnet_id      = aws_subnet.vpc1_public.id
  route_table_id = aws_route_table.vpc1_public_rt.id
}

#############################
# Private Route Table (No NAT)
#############################
resource "aws_route_table" "vpc1_private_rt" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "VPC1-Private-RT"
  }
}

#############################
# Private Route Table Association
#############################
resource "aws_route_table_association" "vpc1_private_assoc" {
  subnet_id      = aws_subnet.vpc1_private.id
  route_table_id = aws_route_table.vpc1_private_rt.id
}
