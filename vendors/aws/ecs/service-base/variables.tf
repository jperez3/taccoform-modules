variable "env" {
  description = "unique environment/stage name"
  type        = string
}

variable "service" {
  description = "unique/short service name"
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

variable "custom_repo_name" {
  description = "overrides the default naming structure for repo creation"
  default     = ""
}

variable "custom_app_name" {
  description = "overrides the default naming structure for app creation"
  default     = ""
}

variable "vpc_name_prefix" {
  description = "prefix for establishing uniqueness between VPCs in same account"
  default     = "main"
}

variable "custom_vpc_name" {
  description = "overrides the default naming structure for VPC creation"
  default     = ""
}


locals {
  cluster_name  = var.custom_cluster_name != "" ? var.custom_cluster_name : "${var.cluster_name_prefix}-${var.env}"
  ecr_repo_name = var.custom_repo_name != "" ? var.custom_repo_name : "${var.service}-${var.env}"
  app_name      = var.custom_app_name != "" ? var.custom_app_name : "${var.app_name}-${var.service}-${var.env}"
  vpc_name      = var.custom_vpc_name != "" ? var.custom_vpc_name : "${var.vpc_name_prefix}-${var.env}"

  common_tags = {
    environment      = var.env
    managed-by       = "terraform"
    ecs-cluster-name = local.cluster_name
  }
}
