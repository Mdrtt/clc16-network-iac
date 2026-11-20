resource "aws_subnet" "public_subnet_1c" {
  vpc_id            = aws_vpc.clc_vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "public_subnet_1c_tf"
  }
}