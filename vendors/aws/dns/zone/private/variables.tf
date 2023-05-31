variable "env" {
  description = "unique environment/stage name"
  type        = string
}

variable "vpc_name" {
  description = "name of VPC to use for private zone creation"
  default     = ""
}


locals {
  common_tags = {
    DNS-Zone    = "private"
    Environment = var.env
    Managed-By  = "terraform"
    VPC-Name    = var.vpc_name
  }
}
