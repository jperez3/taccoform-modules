resource "aws_route53_zone" "public" {
  count = var.vpc_name == "" ? 1 : 0

  name = var.domain

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = var.domain,
      "DNS-Zone" = "public"
    })
  )
}


# Creates a private zone when a VPC NAME is provided
resource "aws_route53_zone" "private" {
  count = var.vpc_name != "" ? 1 : 0

  name = var.domain
  vpc {
    vpc_id = data.aws_vpc.selected[0].id
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name"     = var.domain,
      "DNS-Zone" = "public",
      "VPC-Name" = var.vpc_name
    })
  )
}
