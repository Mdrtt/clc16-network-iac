data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "web_server" {
  #checkov:skip=CKV_AWS_41:AWS Academy lab does not allow IAM role creation
  #checkov:skip=CKV_AWS_88:Public IP is intentional for this web server lab

  ami                         = data.aws_ami.amazon_linux.id
  instance_type                = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1c.id
  vpc_security_group_ids       = [aws_security_group.web_sg.id]
  associate_public_ip_address  = true

  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd

    TOKEN=$(curl -s -X PUT \
      "http://169.254.169.254/latest/api/token" \
      -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    IP=$(curl -s \
      "http://169.254.169.254/latest/meta-data/public-ipv4" \
      -H "X-aws-ec2-metadata-token: $TOKEN")

    echo "http://$IP CHEGUEI ATÉ AQUI - Mateus Duarte de Lima - CLC 16" \
      > /var/www/html/index.html
  EOF

  tags = {
    Name = "web-server-terraform"
  }
}