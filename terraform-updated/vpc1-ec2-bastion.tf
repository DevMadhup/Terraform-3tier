# -------------------------------
# BASTION SECURITY GROUP
# -------------------------------
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH to bastion"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    Name = "bastion-sg"
  }
}

# -------------------------------
# BASTION EC2
# -------------------------------
resource "aws_instance" "bastion" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.vpc1_public.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true

  # ------- Terraform SSH connection ----------
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.ssh_key.private_key_pem
    host        = self.public_ip
  }

  # ---------- Upload PEM file ----------------
  provisioner "file" {
    content     = tls_private_key.ssh_key.private_key_pem
    destination = "/home/ec2-user/terraform-key.pem"
  }

  # ---------- Fix permissions ----------------
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/terraform-key.pem"
    ]
  }

  tags = {
    Name = "Bastion"
  }
}

