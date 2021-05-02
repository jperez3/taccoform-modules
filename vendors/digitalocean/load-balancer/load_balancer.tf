


#################
# Load Balancer #
#################

resource "digitalocean_loadbalancer" "lb" {
  
  droplet_ids = var.droplet_ids
  name        = "lb-${var.service}-${var.env}"
  region      = var.region

  forwarding_rule {
    entry_port      = var.lb_entry_port
    entry_protocol  = var.lb_entry_protocol
    target_port     = var.lb_target_port
    target_protocol = var.lb_target_protocol
  }

  healthcheck {
    port                   = var.lb_health_check_port
    protocol               = var.lb_health_check_protocol
    check_interval_seconds = var.lb_health_check_interval_seconds
    path                   = var.lb_health_check_path
  }
}

output "public_ip" {
  value = digitalocean_loadbalancer.lb.ip
}


#######
# DNS #
#######

resource "digitalocean_record" "lb" {
  count = var.domain != "" ? 1 : 0

  domain = data.digitalocean_domain.default.0.name
  type   = var.dns_record_type
  name   = var.subdomain
  value  = digitalocean_loadbalancer.lb.ip
}
