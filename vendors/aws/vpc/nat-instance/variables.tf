variable "env" {
  description = "unique environment/stage name"
  type        = string
}


locals {
  nat_instance_name = "nat-instance-${local.vpc_name}"
  vpc_name = "${var.vpc_name_prefix}-${var.env}"

  common_tags = {
      Environment = var.env
      Managed_By  = "terraform"
      VPC_Name    = local.vpc_name
  }
}

