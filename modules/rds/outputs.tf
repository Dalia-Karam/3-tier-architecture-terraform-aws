output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.primary.endpoint
}