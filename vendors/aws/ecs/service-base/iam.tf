resource "aws_iam_role" "execution_role" {
  name = "execution-${local.app_name}-${var.env}"
  path = "/${var.env}/${var.service}/${local.app_name}/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF


  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "execution-${local.app_name}-${var.env}"
    })
  )
}



### Create execution role policy 

### Create task role

resource "aws_iam_role" "task_role" {
  name = "task-${local.app_name}-${var.env}"
  path = "/${var.env}/${var.service}/${local.app_name}/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF


  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "task-${local.app_name}-${var.env}"
    })
  )
}


### Create task role policy 
