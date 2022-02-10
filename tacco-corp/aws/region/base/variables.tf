variable "env" {
  description = "unique environment/stage name"
}

variable "domain" {
  description = "domain name to use for environment"
}


locals {
  # removes hyphens from region to shorten dns name
  region = replace(data.aws_region.current.name, "-","")

  subject_alternative_names = concat(var.subject_alternative_names, ["*.${local.region].${var.domain})
}
