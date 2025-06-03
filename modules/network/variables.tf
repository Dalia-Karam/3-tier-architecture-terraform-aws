variable "vpc_cidr" {}

variable "azs" {
  type        = list(string)
  description = "List of availability zones"
}

variable "web_subnet_cidrs" {
  type        = list(string)
  description = "List of web tier public subnet CIDR blocks"
}

variable "app_private_subnet_cidrs" {
  type        = list(string)
  description = "List of app tier private subnet CIDR blocks"
}

variable "db_private_subnet_cidrs" {
  type        = list(string)
  description = "List of database tier private subnet CIDR blocks"
}