variable "visibility" {
    description = "sets repo to public or private"
    default     = "public"
}

variable "template_owner" {
    description = "github owner of repo template"
    default     = "jperez3"
}

variable "template_repository" {
    description = "github repo name to use as template"
    default     = "repo-template-docker"
}
