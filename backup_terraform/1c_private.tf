resource "aws_subnet" "private_subnet_1c" {
  vpc_id            = aws_vpc.clc_vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private_subnet_1c_tf"
  }
}

resource "aws_route_table_association" "rt_pub_association_subnet_1c" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_rt.id
}