# Second private subnet for RDS (required)
resource "aws_subnet" "vpc2_private_2" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "us-east-1c"
  tags              = { Name = "vpc2-private-2" }
}

# Associate to same private route table
resource "aws_route_table_association" "vpc2_private_2_rta" {
  subnet_id      = aws_subnet.vpc2_private_2.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}

