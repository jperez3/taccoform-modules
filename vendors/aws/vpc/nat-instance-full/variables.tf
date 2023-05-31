variable "env" {
  description = "unique environment/stage name"
  type        = string
}

variable "vpc_name_prefix" {
  description = "prefix for establishing uniqueness between VPCs in same account"
  default     = "main"
}

variable "custom_vpc_name" {
  description = "overrides the default naming structure for VPC creation"
  default     = ""
}


locals {
  nat_instance_name = "nat-instance-${local.vpc_name}"
  vpc_name          = var.custom_vpc_name != "" ? var.custom_vpc_name : "${var.vpc_name_prefix}-${var.env}"
  zone_private      = var.custom_vpc_name != "" ? "${var.custom_vpc_name}.${var.env}.${var.domain}" : "${var.vpc_name_prefix}.${var.env}.${var.domain}"

  common_tags = {
    environment = var.env
    managed-by  = "terraform"
    vpc-name    = local.vpc_name
  }
}
