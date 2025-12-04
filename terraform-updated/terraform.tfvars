region = "us-east-1"

#############################
# VPC1 (/24)
#############################
vpc1_cidr         = "10.10.0.0/24"
vpc1_public_cidr  = "10.10.0.0/25"
vpc1_private_cidr = "10.10.0.128/25"

#############################
# VPC2 (/24)
#############################
vpc2_cidr                    = "10.20.0.0/24"
vpc2_private_subnet_1_cidr   = "10.20.0.0/25"
vpc2_private_subnet_2_cidr   = "10.20.0.128/25"

#############################
# AZs
#############################
az1 = "us-east-1a"
az2 = "us-east-1b"

#############################
# EC2 / SSH / NAT
#############################
allowed_ssh_cidr = "0.0.0.0/0"
instance_type    = "t3.micro"
key_name         = "terraform-generated-key"

#############################
# RDS
#############################
db_username          = "admin"
db_password          = "Password123!"
db_allocated_storage = 20
db_instance_class    = "db.t3.micro"

