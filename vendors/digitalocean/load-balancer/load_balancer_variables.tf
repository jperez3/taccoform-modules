variable "droplet_ids" {
  description = "list of droplet IDs to be added to load balancer pool"
}

variable "lb_entry_port" {
  description = "load balancer entry port"
  default     = 80
}

variable "lb_entry_protocol" {
  description = "load balancer entry protocol"
  default     = "http"
}

variable "lb_target_port" {
  description = "load balancer target port"
  default     = 80
}

variable "lb_target_protocol" {
  description = "load balancer target protocol"
  default     = "http"
}

variable "lb_health_check_port" {
  description = "load balancer health check port"
  default     = 80
}

variable "lb_health_check_protocol" {
  description = "load balancer health check protocol"
  default     = "http"
}

variable "lb_health_check_interval_seconds" {
  description = "load balancer health check interval seconds"
  default     = 5
}

variable "lb_health_check_path" {
  description = "load balancer health check path"
  default     = "/"
}

#################
# DNS Variables #
#################

variable "domain" {
  description = "your custom domain name"
  default     = ""
}

variable "subdomain" {
  description = "subdomain for certificate and dns"
  default     = "www"
}

variable "dns_record_type" {
  description = "DNS record type for web"
  default     = "A"
}


