module "dns_zone" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/aws/dns/zone/public?ref=region-base"

  domain = var.domain
  env    = var.env

}

output "nameservers" {
  description = "the nameservers for your route53 zone"
  value       = module.dns_zone.nameservers
}
