module "loadbalancer" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/digitalocean/load-balancer?ref=do-lb-v1.0.0"

  env         = var.env
  subdomain   = var.lb_subdomain
  domain      = var.domain
  droplet_ids = module.droplet.droplet_ids
  service     = var.service
}

output "lb_public_ip" {
  value = module.loadbalancer.public_ip
}
