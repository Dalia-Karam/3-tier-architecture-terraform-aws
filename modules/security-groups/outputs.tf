output "external_alb_sg" {
  value = aws_security_group.external_alb_sg.id
}

output "web_sg" {
    value = aws_security_group.web_sg.id
}

output "internal_alb_sg" {
  value = aws_security_group.internal_alb_sg.id
}

output "app_sg" {
  value = aws_security_group.app_sg.id
}

output "rds_sg" {
  value = aws_security_group.rds_sg.id
}