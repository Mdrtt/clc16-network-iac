output "public_subnet_1c" {
  value = aws_subnet.public_subnet_1c.id
}

output "private_subnet_1c" {
  value = aws_subnet.private_subnet_1c.id
}

output "rt_pub_association_subnet_1c" {
  value = aws_route_table_association.rt_pub_association_subnet_1c.id
}

output "eip_nat_gw_1c" {
  value = aws_eip.eip_nat_gw_1c.id
}

output "nat_gw_1c" {
  value = aws_nat_gateway.nat_gw_1c.id
}

output "private_rt_1c" {
  value = aws_route_table.private_rt_1c.id
}

output "web_sg" {
  value = aws_security_group.web_sg.id
}

output "ec2_id" {
  value = aws_instance.web_server.id
}

output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.web_server.public_dns
}