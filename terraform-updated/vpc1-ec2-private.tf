resource "aws_security_group" "private_ec2_sg" {
  name   = "private-ec2-sg"
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
}

resource "aws_instance" "private_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.vpc1_private.id
  vpc_security_group_ids      = [aws_security_group.private_ec2_sg.id]
  associate_public_ip_address = false
  key_name                    = var.key_name
  tags                        = { Name = "Private-EC2" }
}

