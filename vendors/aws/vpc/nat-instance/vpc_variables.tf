variable "cidr_block" {
  description = "CIDR block for VPC to create"
}

variable "vpc_name_prefix" {
  description = "prefix for establishing uniqueness between VPCs in same account"
  default     = "main"
}

variable "private_subnets" {
  description = "list of private subnets to create based on the provided CIDR block"
}

variable "public_subnets" {
  description = "list of public subnets to create based on the provided CIDR block"
}


locals {
  vpc_name = "${var.vpc_name_prefix}-${var.env}"
}