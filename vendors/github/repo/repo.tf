resource "github_repository" "service" {
  name        = var.service
  description = "github repo for ${var.service}"

  visibility = var.repo_visbility

  template {
    owner      = var.template_owner
    repository = var.template_repository
  }
