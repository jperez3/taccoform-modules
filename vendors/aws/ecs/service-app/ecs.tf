resource "aws_ecs_service" "app" {
  name            = local.app_name
  cluster         = data.aws_ecs_cluster.current.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 2
  iam_role        = aws_iam_role.foo.arn
  #   depends_on      = [aws_iam_role_policy.foo]



  #   load_balancer {
  #     target_group_arn = aws_lb_target_group.foo.arn
  #     container_name   = local.app_name
  #     container_port   = 8080
  #   }

  dynamic "load_balancer" {
    for_each = local.ecs_lb_config

    content {
      target_group_arn = lb.value.target_group_arn
      container_name   = lb.value.container_name
      container_port   = lb.value.container_port
    }
  }


  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.app_name
    })
  )
}


resource "aws_appautoscaling_target" "app" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${local.ecs_cluster_name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}


resource "aws_appautoscaling_policy" "app_target_cpu" {
  name               = "cpu-${local.app_name}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.app.resource_id
  scalable_dimension = aws_appautoscaling_target.app.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 80
  }
  depends_on = [aws_appautoscaling_target.app]
}


resource "aws_appautoscaling_policy" "app_target_mem" {
  name               = "mem-${local.app_name}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.app.resource_id
  scalable_dimension = aws_appautoscaling_target.app.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80
  }
  depends_on = [aws_appautoscaling_target.app]
}
