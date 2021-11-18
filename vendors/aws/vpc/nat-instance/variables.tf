variable "env" {
  description = "unique environment/stage name"
  type        = string
}


locals {
  nat_instance_name = "nat-instance-${local.vpc_name}"
}