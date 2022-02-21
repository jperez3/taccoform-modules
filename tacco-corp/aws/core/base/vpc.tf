module "vpc" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/aws/vpc/nat-instance?ref=aws-vpc-ni-v1.0.0"

  env = var.env

  cidr_block              = var.cidr_block
  enable_jumpbox_instance = var.enable_jumpbox_instance
  vpc_name_prefix         = var.vpc_name_prefix
}
