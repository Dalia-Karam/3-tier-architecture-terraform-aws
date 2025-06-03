output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "app_private_subnet_ids" {
  value = aws_subnet.app_private[*].id
}

output "db_private_subnet_ids" {
  value = aws_subnet.db_private[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway[*].id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}