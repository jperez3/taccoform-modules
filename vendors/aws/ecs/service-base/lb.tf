resource "aws_lb_target_group" "app" {
  count = var.container_port != "" ? 1 : 0

  name     = "${var.container_port}-${local.app_name}-${var.env}"
  port     = var.container_port
  protocol = var.container_protocol
  vpc_id   = data.aws_vpc.selected.id


  health_check {
    matcher = var.health_check_matcher
    path    = var.health_check_path
    port    = var.container_port
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${var.container_port}-${local.app_name}-${var.env}"
    })
  )
}

resource "random_integer" "listener_priority" {
  min = 1
  max = 50000
  keepers = {
    # Generate a new integer each time we switch to a new listener ARN
    listener_arn = "${var.listener_arn}"
  }
}

resource "aws_lb_listener_rule" "app" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = random_integer.listener_priority.result

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    host_header {
      values = ["my-service.*.${var.domain}"]
    }
  }
}
