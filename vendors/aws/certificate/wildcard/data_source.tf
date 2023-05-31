data "aws_route53_zone" "public" {
  name         = var.domain
  private_zone = false
}
