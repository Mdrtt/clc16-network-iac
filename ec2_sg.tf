
resource "aws_security_group" "web_sg" {
  name        = "web-sg-terraform"
  description = "Security group for public web server"
  vpc_id      = aws_vpc.clc_vpc.id

  #checkov:skip=CKV_AWS_260:Public HTTP is required for this web server lab
  #checkov:skip=CKV_AWS_382:Outbound access is required for package installation and web server operation

  ingress {
    description = "HTTP public access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH restricted to administrator IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    description = "HTTP outbound access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS outbound access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg_tf"
  }
}
