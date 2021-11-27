variable "env" {
  description = "unique environment/stage name"
  type        = string
}


variable "cluster_name_prefix" {
  description = "prefix for establishing uniqueness between VPCs in same account"
  default     = "shared"
}

variable "custom_cluster_name" {
  description = "overrides the default naming structure for ECS cluster creation"
  default     = ""
}


locals {
  cluster_name = var.custom_cluster_name != "" ? var.custom_cluster_name : "${var.cluster_name_prefix}-${var.env}"

  common_tags = {
    environment      = var.env
    managed-by       = "terraform"
    ecs-cluster-name = local.cluster_name
  }
}
