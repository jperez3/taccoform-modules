variable "cidr_block" {
  description = "the CIDR block for VPC to use"
  default     = "10.123.0.0"
}

variable "enable_jumpbox_instance" {
  description = "Creates jumpbox instance to validate NAT instance functionality"
  default     = false
}

variable "vpc_name_prefix" {
    description = "name prefix to apply to vpc"
    default     = "core"
}
