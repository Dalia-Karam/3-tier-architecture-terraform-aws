output "web_alb_dns_name" {
  value = aws_lb.web.dns_name
}

output "app_alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "web_asg_name" {
  value = aws_autoscaling_group.web.name
}

output "app_asg_name" {
  value = aws_autoscaling_group.app.name
}
