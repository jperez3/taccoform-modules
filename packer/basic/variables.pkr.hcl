variable "env" {
  description = "unique environment/stage name"
  default     = "prod"
}

variable "service" {
  description = "unique service name"
  default     = "burrito"
}

variable "region" {
  description = "AWS region name"
  default     = "us-east-1"
}

locals {
  identifier       = "taccoform-${var.service}"
  timestamp        = regex_replace(timestamp(), "[- TZ:]", "")

  ami_name         = "${local.identifier}-${local.timestamp}"
}
