variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR blocks"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR blocks"
}

variable "eu_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}

variable "public_key" {
  type        = string
  description = "Public key for EC2 instances"
}

variable "ec2_ami_id" {
  type        = string
  description = "AMI ID for EC2 instances"
}

variable "dev_proj_1_acm_arn" {
  description = "ACM certificate ARN for HTTPS ALB listener"
  type        = string
}