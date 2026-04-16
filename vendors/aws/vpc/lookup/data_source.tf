data "aws_vpcs" "in_region" {}

data "aws_vpc" "selected" {
  for_each = toset(data.aws_vpcs.in_region.ids)
  id       = each.value
}

locals {
  vpc_map            = { for vpc_id, vpc_info in data.aws_vpc.selected : vpc_info.tags["Name"] => vpc_id }
  vpc_names_all      = [for vpc_name, vpc_id in local.vpc_map : vpc_name]
  vpc_names_filtered = [for vpc_name, vpc_id in local.vpc_map : vpc_name if !contains(["default"], vpc_name)]
}

output "vpc_map" {
  value = local.vpc_map
}

output "vpc_names_all" {
  value = local.vpc_names_all
}

output "vpc_names_filtered" {
  value = local.vpc_names_filtered
}
