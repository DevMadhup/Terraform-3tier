resource "aws_db_instance" "vpc2_rds" {
  identifier        = "vpc2-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  username = "admin"
  password = "Admin12345!"

  db_subnet_group_name   = aws_db_subnet_group.vpc2_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.vpc2_rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name = "vpc2-rds"
  }
}

