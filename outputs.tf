output "vpc1_id" {
  value = aws_vpc.vpc1.id
}

output "vpc2_id" {
  value = aws_vpc.vpc2.id
}

output "rds_endpoint" {
  value = aws_db_instance.vpc2_rds.address
}

