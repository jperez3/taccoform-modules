##############
# Packer IAM #
##############

resource "aws_iam_role" "packer" {
  name = "packer"

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
  name = "packer"
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

  name = "vpc1"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = true

  vpc_tags = {
    Name = "vpc1"
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
    value - aws_iam_instance_profile.packer.name
}
