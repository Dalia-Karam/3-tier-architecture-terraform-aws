variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for web tier"
  type        = list(string)
}

variable "private_app_subnet_ids" {
  description = "Private app subnet IDs"
  type        = list(string)
}

variable "external_alb_sg_ids" {
  description = "Security group IDs for external ALB"
  type        = list(string)
}

variable "internal_alb_sg_ids" {
  description = "Security group IDs for internal ALB"
  type        = list(string)
}

variable "web_sg_ids" {
  description = "Security group IDs for web instances"
  type        = list(string)
}

variable "app_sg_ids" {
  description = "Security group IDs for app instances"
  type        = list(string)
}

variable "web_ami_id" {
  description = "AMI ID for web tier instances"
  type        = string
}

variable "app_ami_id" {
  description = "AMI ID for app tier instances"
  type        = string
}

variable "web_instance_type" {
  description = "Instance type for web tier"
  type        = string
}

variable "app_instance_type" {
  description = "Instance type for app tier"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = ""
}

variable "web_desired_capacity" {
  description = "Desired ASG capacity for web tier"
  type        = number
}

variable "web_min_size" {
  description = "Minimum ASG size for web tier"
  type        = number
}

variable "web_max_size" {
  description = "Maximum ASG size for web tier"
  type        = number
  default     = 3
}

variable "app_desired_capacity" {
  description = "Desired ASG capacity for app tier"
  type        = number
}

variable "app_min_size" {
  description = "Minimum ASG size for app tier"
  type        = number
}

variable "app_max_size" {
  description = "Maximum ASG size for app tier"
  type        = number
}
