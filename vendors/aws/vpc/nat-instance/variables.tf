variable "region" {
  description = "AWS region name for resource placement"
  default     = "us-east-1"
  type        = string
}

variable "env" {
  description = "unique environment/stage name"
  type        = string
}


locals {
  nat_instance_name = "nat-instance-${local.vpc_name}"
}