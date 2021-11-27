variable "log_retention_in_days" {
  description = "days to keep logs"
  default     = 14
}

variable "capacity_providers" {
  description = "list of capacity providers to use with this cluster"
  default     = ["FARGATE"]
}

variable "enable_container_insights" {
  description = "enables container insights on cluster"
  default     = "enabled"

}
