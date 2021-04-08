resource "digitalocean_droplet" "vm" {
  count = var.droplet_count

  image      = var.droplet_image
  monitoring = var.droplet_monitoring
  name       = "${var.droplet_node_type}${count.index}-${var.service}-${var.env}"
  region     = var.region
  size       = var.droplet_size
}
