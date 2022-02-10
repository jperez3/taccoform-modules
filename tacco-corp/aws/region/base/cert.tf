module "wildcard_cert" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/aws/certificate/wildcard?ref=region-base"

  domain = var.domain
  env    = var.env
  subject_alternative_names = var.subject_alternative_names

}
