data "digitalocean_domain" "default" {
  count = var.domain != "" ? 1 : 0

  name = var.domain
}
