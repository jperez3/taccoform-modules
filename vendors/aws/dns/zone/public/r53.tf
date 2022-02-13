resource "aws_route53_zone" "public" {

  name = var.domain

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = var.domain,
    })
  )
}

output "name_servers" {
  description = "list of name servers for zone"
  value       = flatten(aws_route53_zone.public.name_servers)
}
