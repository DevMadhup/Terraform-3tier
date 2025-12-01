resource "aws_security_group" "vpc2_rds_sg" {
  name        = "vpc2-rds-sg"
  vpc_id      = aws_vpc.vpc2.id
  description = "Allow DB access only from private EC2"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc2_private_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc2-rds-sg"
  }
}

