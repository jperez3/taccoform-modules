resource "aws_iam_role" "autoscale" {
  name = "autoscale-${local.cluster_name}"
  path = "/${var.env}/${local.cluster_name}/"

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
      "Name" = "autoscale-${local.cluster_name}"
    })
  )
}

resource "aws_iam_role_policy_attachment" "autoscale" {
  role = aws_iam_role.autoscale.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
