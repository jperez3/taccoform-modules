variable "env" {
  description = "unique/short environment name"
}

variable "extra_tags" {
  description = "list of extra tags to attach to resources"
  default     = {}
}




locals {

  azs             = data.aws_availability_zones.available.names
  private_subnets = []
  public_subnets  = []

  common_tags = {
    Environment = var.env
  }

}
