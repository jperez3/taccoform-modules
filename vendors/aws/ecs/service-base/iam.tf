resource "aws_iam_role" "execution_role" {
  name = "execution-${local.app_name}"

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
}



### Create execution role policy 

### Create task role

### Create task role policy 
