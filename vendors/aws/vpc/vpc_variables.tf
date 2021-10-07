variable "vpc_name" {
  descrption = "short/unique vpc name"
}

variable "cidr_block" {
  description = "a CIDR notation network block, eg 10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "enables/disables DNS hostnames"
  default     = true
}

variable "enable_dns_support" {
  description = "enables/disables DNS support"
  default     = true
}
