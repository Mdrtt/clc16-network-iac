# =========================================================
# VPC
# =========================================================

resource "aws_vpc" "clc_vpc" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_terraform_tf"
  }
}


# =========================================================
# SUBNETS - AZ 1A
# =========================================================

resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.clc_vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public_subnet_1a_tf"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.clc_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet_1a_tf"
  }
}


# =========================================================
# SUBNETS - AZ 1C
# =========================================================

resource "aws_subnet" "public_subnet_1c" {
  vpc_id            = aws_vpc.clc_vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "public_subnet_1c_tf"
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id            = aws_vpc.clc_vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private_subnet_1c_tf"
  }
}


# =========================================================
# INTERNET GATEWAY
# =========================================================

resource "aws_internet_gateway" "gw_clc_vpc" {
  vpc_id = aws_vpc.clc_vpc.id

  tags = {
    Name = "igw_clc_vpc_tf"
  }
}


# =========================================================
# PUBLIC ROUTE TABLE
# =========================================================

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.clc_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_clc_vpc.id
  }

  tags = {
    Name = "public_rt_tf"
  }
}


# =========================================================
# PUBLIC ROUTE TABLE ASSOCIATIONS
# =========================================================

resource "aws_route_table_association" "rt_pub_association_subnet_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "rt_pub_association_subnet_1c" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_rt.id
}


# =========================================================
# NAT GATEWAY - AZ 1A
# =========================================================

resource "aws_eip" "eip_nat_gw_1a" {
  domain = "vpc"

  tags = {
    Name = "eip_nat_gw_1a_tf"
  }
}

resource "aws_nat_gateway" "nat_gw_1a" {
  allocation_id = aws_eip.eip_nat_gw_1a.id
  subnet_id     = aws_subnet.public_subnet_1a.id

  tags = {
    Name = "nat_gw_1a_tf"
  }

  depends_on = [
    aws_internet_gateway.gw_clc_vpc
  ]
}


# =========================================================
# NAT GATEWAY - AZ 1C
# =========================================================

resource "aws_eip" "eip_nat_gw_1c" {
  domain = "vpc"

  tags = {
    Name = "eip_nat_gw_1c_tf"
  }
}

resource "aws_nat_gateway" "nat_gw_1c" {
  allocation_id = aws_eip.eip_nat_gw_1c.id
  subnet_id     = aws_subnet.public_subnet_1c.id

  tags = {
    Name = "nat_gw_1c_tf"
  }

  depends_on = [
    aws_internet_gateway.gw_clc_vpc
  ]
}


# =========================================================
# PRIVATE ROUTE TABLE - AZ 1A
# =========================================================

resource "aws_route_table" "private_rt_1a" {
  vpc_id = aws_vpc.clc_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1a.id
  }

  tags = {
    Name = "private_rt_1a_tf"
  }
}


# =========================================================
# PRIVATE ROUTE TABLE - AZ 1C
# =========================================================

resource "aws_route_table" "private_rt_1c" {
  vpc_id = aws_vpc.clc_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1c.id
  }

  tags = {
    Name = "private_rt_1c_tf"
  }
}


# =========================================================
# PRIVATE ROUTE TABLE ASSOCIATIONS
# =========================================================

resource "aws_route_table_association" "rt_priv_association_subnet_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_rt_1a.id
}

resource "aws_route_table_association" "rt_priv_association_subnet_1c" {
  subnet_id      = aws_subnet.private_subnet_1c.id
  route_table_id = aws_route_table.private_rt_1c.id
}