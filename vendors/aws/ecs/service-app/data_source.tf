data "aws_ecs_cluster" "selected" {
  cluster_name = local.ecs_cluster_name
}


data "aws_lb_target_group" "app" {
  name = local.target_group_name
}
