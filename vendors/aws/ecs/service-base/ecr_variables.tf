variable "enable_ecr_repo" {
  description = "enables/disables ECR repo creation"
  default     = true
}

variable "ecr_lifecycle_policy" {
  description = "policy in json format for ecr lifecycle"
  default     = ""
}
