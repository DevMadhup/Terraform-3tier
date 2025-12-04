#######################################
# Private Subnet 1 (AZ1)
#######################################
resource "aws_subnet" "vpc2_private_1" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.vpc2_private_subnet_1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "VPC2-Private-Subnet-AZ1"
  }
}

#######################################
# Private Subnet 2 (AZ2)
#######################################
resource "aws_subnet" "vpc2_private_2" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.vpc2_private_subnet_2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "VPC2-Private-Subnet-AZ2"
  }
}

