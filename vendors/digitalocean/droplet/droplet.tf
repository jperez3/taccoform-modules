resource "digitalocean_droplet" "vm" {
  count = var.droplet_count

  image      = var.droplet_image
  monitoring = var.droplet_monitoring
  name       = "${var.droplet_node_type}${count.index}-${var.service}-${var.env}"
  region     = var.region
  size       = var.droplet_size
  user_data  = templatefile("${path.module}/templates/user_data.yaml", { hostname = "web${count.index}-${var.service}-${var.env}" })
}

output "droplet_ids" {
  description = "list of droplet IDs"
  value       = digitalocean_droplet.vm.*.id
}
