module "droplet" {
  // source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/digitalocean/droplet?ref=do-droplet-v1.0.0"
  source = "../../../vendors/digitalocean/droplet"

  env     = var.env
  service = var.service
}

output "droplet_ids" {
  value = module.droplet.droplet_ids
}
