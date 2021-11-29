variable "container_port" {
  description = "container TCP port for target group"
  default     = ""
}

variable "container_protocol" {
  description = "container protocol for target group"
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "matcher/code to use for target group health check"
  default     = "200"
}

variable "health_check_path" {
  description = "path to use for target group health check"
  default     = "/"
}

variable "custom_alb_listener_name" {
    description = "overrides the default shared listener for the target group to attach to"
    default     = ""
}


locals {
  alb_listener_name = var.custom_alb_listener_name != "" ? var.custom_alb_listener_name : "HTTPS-443-${local.cluster_name}"
}
