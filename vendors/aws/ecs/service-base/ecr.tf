resource "aws_ecr_repository" "repo" {
  count = var.enable_ecr_repo ? 1 : 0

  name = local.ecr_repo_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.ecr_repo_name
    })
  )
}


resource "aws_ecr_lifecycle_policy" "image" {
  count = var.ecr_lifecycle_policy != "" && var.enable_ecr_repo ? 1 : 0

  repository = aws_ecr_repository.repo.name
  policy     = var.ecr_lifecycle_policy
}
