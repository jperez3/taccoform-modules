resource "aws_route53_zone" "private" {
  count = var.vpc_name != "" ? 1 : 0

  name = var.domain
  vpc {
    vpc_id = data.aws_vpc.selected[0].id
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = var.domain,
    })
  )
}

output "name_servers" {
  count = var.vpc_name != "" ? 1 : 0
  value = aws_route53_zone.public.name_servers
}
