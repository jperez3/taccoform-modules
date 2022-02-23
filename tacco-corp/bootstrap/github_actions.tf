# data "aws_iam_policy_document" "github_actions_assume_role" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     principals {
#       type        = "Federated"
#       identifiers = [var.openid_connect_provider.arn]
#     }
#     condition {
#       test     = "StringLike"
#       variable = "token.actions.githubusercontent.com:sub"
#       values   = ["repo:${var.organization}/${var.service}:*"]
#     }
#   }
# }

# resource "aws_iam_role" "github_actions" {
#   name               = "github-actions-${var.organization}-${var.service}"
#   assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
# }


# data "aws_iam_policy_document" "github_actions" {
#   statement {
#     actions = [
#       "ecr:BatchGetImage",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:CompleteLayerUpload",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:InitiateLayerUpload",
#       "ecr:PutImage",
#       "ecr:UploadLayerPart",
#     ]
#     resources = [aws_ecr_repository.service.arn]
#   }

#   statement {
#     actions = [
#       "ecr:GetAuthorizationToken",
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_policy" "github_actions" {
#   name        = "github-actions-${var.service}"
#   description = "Grant Github Actions the ability to push to ${var.service} from ${var.organization}/${var.service}"
#   policy      = data.aws_iam_policy_document.github_actions.json
# }

# resource "aws_iam_role_policy_attachment" "github_actions" {
#   role       = aws_iam_role.github_actions.name
#   policy_arn = aws_iam_policy.github_actions.arn
# }
