resource "aws_acm_certificate" "wildcard" {
  domain_name       = var.domain
  validation_method = "DNS"


  subject_alternative_names = concat(["*.${var.domain}"], var.subject_alternative_names)

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = var.domain,
      "Cert-Type" = "wildcard"
    })
  )
}

resource "aws_route53_record" "wildcard" {
  for_each = {
    for dvo in aws_acm_certificate.wildcard.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public.zone_id
}

resource "aws_acm_certificate_validation" "wildcard" {
  certificate_arn         = aws_acm_certificate.wildcard.arn
  validation_record_fqdns = [for record in aws_route53_record.wildcard : record.fqdn]
}
