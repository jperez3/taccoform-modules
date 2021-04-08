variable "droplet_count" {
  description = "the number of droplets to provision"
  default     = 2
}

variable "droplet_image" {
  description = "the DigitalOcean droplet image ID"
  default     = "ubuntu-18-04-x64"
}

variable "droplet_monitoring" {
  description = "the DigitalOcean droplet image ID"
  default     = true
}

variable "droplet_node_type" {
  description = "the node/droplet/vm type, eg app, web, db"
  default     = "web"
}

variable "droplet_size" {
  description = "the DigitalOcean droplet size"
  default     = "s-1vcpu-1gb"
}
