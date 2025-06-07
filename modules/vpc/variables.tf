variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  
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


variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  
}
