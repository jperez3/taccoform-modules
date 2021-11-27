resource "aws_kms_key" "shared_cluster" {
  description             = "${local.cluster_name} logging"
  deletion_window_in_days = 7

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.cluster_name
    })
  )
}

resource "aws_cloudwatch_log_group" "shared_cluster" {
  name              = "/aws/ecs/${local.cluster_name}"
  retention_in_days = var.log_retention_in_days

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.cluster_name
    })
  )

}

resource "aws_ecs_cluster" "shared_cluster" {
  name               = local.cluster_name
  capacity_providers = var.capacity_providers

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.shared_cluster.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.shared_cluster.name
      }
    }
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.cluster_name
    })
  )
}
