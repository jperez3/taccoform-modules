resource "aws_route53_zone" "private" {

  name = local.zone_private
  vpc {
    vpc_id = aws_vpc.current.id
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.zone_private,
    })
  )
}

output "name_servers_private" {
  value = aws_route53_zone.private.name_servers
}
