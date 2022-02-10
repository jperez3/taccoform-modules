variable "env" {
  description = "unique environment/stage name"
  type        = string
}

variable "domain" {
  description = "domain name to use for environment"
}

locals {
  common_tags = {
    Environment      = var.env
    Managed-By       = "terraform"
  }
}
