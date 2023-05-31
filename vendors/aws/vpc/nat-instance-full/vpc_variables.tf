variable "cidr_block" {
  description = "the CIDR block for VPC to use"
  default     = ""
  type        = string

  validation {
    condition     = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cidr_block))
    error_message = "Invalid CIDR provided, try the format 10.X.0.0 where X is a number betweeen 1 and 253."
  }
}


locals {
  # Creates a 10.x.0.0/16 CIDR block if one isn't provided 
  cidr_block = var.cidr_block != "" ? "${var.cidr_block}/16" : "10.123.0.0/16"

  # spliting the user provided CIDR block into two /19 private subnets and two /20 public subnets
  cidr_split      = flatten(cidrsubnets(local.cidr_block, 3, 3, 4, 4))
  private_subnets = slice(local.cidr_split, 0, 2)
  public_subnets  = slice(local.cidr_split, 2, 4)

}
