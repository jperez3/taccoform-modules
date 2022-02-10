module "dns_zone" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/aws/dns/zone?ref=region-base"

  domain = var.domain
  env    = var.env

}
