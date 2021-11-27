data "aws_ecs_cluster" "current" {
  cluster_name = local.ecs_cluster_name
}


data "aws_lb_target_group" "app" {
  name = local.target_group_name
}
