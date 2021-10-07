resource "aws_vpc" "default" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    local.common_tags,
    var.extra_tags,
    map(
      "Name", var.vpc_name,
    )
  )
}

