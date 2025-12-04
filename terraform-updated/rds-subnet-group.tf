resource "aws_db_subnet_group" "rds_subnet" {
  name = "rds-subnet-group"

  subnet_ids = [
    aws_subnet.vpc2_private_1.id,
    aws_subnet.vpc2_private_2.id
  ]

  tags = {
    Name = "RDS-Subnet-Group"
  }
}

