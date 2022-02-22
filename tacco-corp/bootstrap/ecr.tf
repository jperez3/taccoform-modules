resource "aws_ecr_repository" "service" {

  count = var.enable_ecr

  name = var.service

  image_scanning_configuration {
    scan_on_push = true
  }
}
