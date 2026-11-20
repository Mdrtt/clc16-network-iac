resource "aws_eip" "eip_nat_gw_1c" {
  domain = "vpc"

  tags = {
    Name = "eip_nat_gw_1c_tf"
  }
}