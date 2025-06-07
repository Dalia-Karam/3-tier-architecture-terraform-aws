variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "region" {
  description = "Region"
  type = string
}

variable "public_subnets_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  
}

variable "private_app_subnets_cidrs" {
  description = "List of CIDR blocks for private application subnets"
  type        = list(string)
}

variable "private_db_subnets_cidrs" {
  description = "List of CIDR blocks for private database subnets"
  type        = list(string)
}

variable "username" {
  description = "Database username"
  type        = string
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "web_desired_capacity" {
  type        = number
  description = "Desired ASG capacity for web tier"
}

variable "web_min_size" {
  type        = number
  description = "Min ASG size for web tier"
}

variable "web_max_size" {
  type        = number
  description = "Max ASG size for web tier"
}

variable "app_desired_capacity" {
  type        = number
  description = "Desired ASG capacity for app tier"
}

variable "app_min_size" {
  type        = number
  description = "Min ASG size for app tier"
}

variable "app_max_size" {
  type        = number
  description = "Max ASG size for app tier"
}
