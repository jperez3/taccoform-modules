variable "ecs_cluster_name" {
  description = "ecs cluster to use for service"
  default     = ""

}

variable "target_group_name" {
  description = "the application's target group name"
  default     = ""
}

locals {
  ecs_cluster_name  = var.ecs_cluster_name != "" ? var.ecs_cluster_name : "${var.cluster_name_prefix}-${var.env}"
  target_group_name = var.target_group_name != "" ? var.target_group_name : local.app_name

  ecs_lb_config = var.container_port == "" ? {} : [{
    target_group_arn = data.aws_lb_target_group.app.arn
    container_name   = local.app_name
    container_port   = var.container_port
  }]
}
