variable "service" {
  description = "unique service name"
}

variable "enable_github_repo" {
  description = "enables/disables creation of github repo"
  default     = 1
}

variable "enable_ecr" {
  description = "enables/disables creation of ecr repo"
  default     = 1
}

variable "enable_dd_monitor" {
  description = "enables/disables creation of datadog monitor"
  default     = 1
}
