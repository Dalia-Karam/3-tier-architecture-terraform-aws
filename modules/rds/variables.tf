variable "db_username" {
  type        = string
  description = "Master DB username"
}

variable "db_password" {
  type        = string
  description = "Master DB password"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Initial database name"
}

variable "db_subnet_id" {
  type        = list(string)
  description = "List of private subnet IDs for RDS"
}

variable "rds_sg_ids" {
  type        = list(string)
  description = "List of security group IDs for the RDS instance"
}

