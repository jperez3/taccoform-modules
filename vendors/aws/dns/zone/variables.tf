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
    Environment = var.env
    Managed-by  = "terraform"
  }
}
