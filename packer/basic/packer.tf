############
# Provider #
############

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Company     = "tacco-corp"
      Environment = "prod"
      Service     = "burrito"
      TFWorkspace = "taccoform-modules/packer/basic"
    }
  }
}


##############
# Packer IAM #
##############

locals {
  name = "taccoform-packer"
}

resource "aws_iam_role" "packer" {
  name = local.name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "packer" {
  name = local.name
  role = aws_iam_role.packer.name
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.packer.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


#######
# VPC #
#######

data "aws_region" "current" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  azs                = ["${data.aws_region.current.name}a"]
  cidr               = "10.0.0.0/16"
  enable_nat_gateway = true
  private_subnets    = ["10.0.1.0/24"]
  public_subnets     = ["10.0.2.0/24"]
  name               = local.name

  vpc_tags = {
    Name = local.name
  }
}

###########
# Outputs #
###########

output  "vpc_id" {
    value = module.vpc.vpc_id
}

output "private_subnet_id" {
    value = module.vpc.private_subnets[0]
}

output "iam_instance_profile" {
    value = aws_iam_instance_profile.packer.name
}
