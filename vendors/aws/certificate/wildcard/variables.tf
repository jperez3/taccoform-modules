variable "env" {
  description = "unique environment/stage name"
  type        = string
}

locals {
  common_tags = {
    Environment      = var.env
    Managed-By       = "terraform"
  }
}
