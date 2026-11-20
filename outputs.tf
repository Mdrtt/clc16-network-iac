output "id_vpc" {
  value = aws_vpc.clc_vpc.id
}

output "public_subnet_1a" {
  value = aws_subnet.public_subnet_1a.id
}

output "private_subnet_1a" {
  value = aws_subnet.private_subnet_1a.id
}

output "public_rt" {
  value = aws_route_table.public_rt.id
}

output "igw_clc_vpc" {
  value = aws_internet_gateway.gw_clc_vpc.id
}

output "rt_pub_association_subnet_1a" {
  value = aws_route_table_association.rt_pub_association_subnet_1a.id
}

output "eip_nat_gw_1a" {
  value = aws_eip.eip_nat_gw_1a.id
}

output "nat_gw_1a" {
  value = aws_nat_gateway.nat_gw_1a.id
}

output "private_rt_1a" {
  value = aws_route_table.private_rt_1a.id
}

output "rt_priv_association_subnet_1a" {
  value = aws_route_table_association.rt_priv_association_subnet_1a.id
}
