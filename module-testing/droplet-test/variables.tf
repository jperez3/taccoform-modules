variable "do_token" {
  description = "DigitalOcean authentication token for terraform provider"
}

variable "env" {
  description = "unique environment name"
  default     = "stg"
}

variable "service" {
  description = "unique service name"
  default     = "burrito"
}
