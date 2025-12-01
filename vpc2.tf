########################################
#               VPC 2
########################################

resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
  tags       = { Name = "vpc2" }
}

resource "aws_subnet" "vpc2_public" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags                    = { Name = "vpc2-public" }
}

resource "aws_subnet" "vpc2_private" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"
  tags              = { Name = "vpc2-private" }
}

resource "aws_internet_gateway" "vpc2_igw" {
  vpc_id = aws_vpc.vpc2.id
}

resource "aws_eip" "vpc2_nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "vpc2_nat" {
  allocation_id = aws_eip.vpc2_nat_eip.id
  subnet_id     = aws_subnet.vpc2_public.id
}

#############################
# PUBLIC ROUTE TABLE
#############################

resource "aws_route_table" "vpc2_public_rt" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc2_igw.id
  }
}

resource "aws_route_table_association" "vpc2_public_rta" {
  subnet_id      = aws_subnet.vpc2_public.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}

#############################
# PRIVATE ROUTE TABLE (Fixed)
#############################

resource "aws_route_table" "vpc2_private_rt" {
  vpc_id = aws_vpc.vpc2.id

  # NAT -> Internet for outbound
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc2_nat.id
  }

  # >>> REQUIRED ROUTE FOR VPC PEERING <<<
  route {
    cidr_block                = aws_vpc.vpc1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_to_vpc2.id
  }
}

resource "aws_route_table_association" "vpc2_private_rta" {
  subnet_id      = aws_subnet.vpc2_private.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}

