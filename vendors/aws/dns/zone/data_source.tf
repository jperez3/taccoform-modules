data "aws_vpc" "selected" {
  count = var.vpc_name != "" ? 1 : 0

  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}
