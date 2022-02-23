### Had to follow this AWS doc to get the thumbprint
### https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
resource "aws_iam_openid_connect_provider" "github_actions" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["15E29108718111E59B3DAD31954647E3C344A231"]
  url             = "https://token.actions.githubusercontent.com"
}
