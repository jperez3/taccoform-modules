module "repo" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/github/repo?ref=bootstrap"

  count = var.enable_github_repo

  service = var.service
}
