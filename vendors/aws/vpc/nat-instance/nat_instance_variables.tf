variable "nat_instance_count" {
  description = "number of NAT instances to provision"
  default     = 2
}

variable "nat_intance_type" {
  description = "low-cost instance type for NAT instance"
  default     = "t3a.nano"
}

