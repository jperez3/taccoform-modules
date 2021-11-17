#######
# IAM #
#######

resource "aws_iam_role" "ec2" {
  name               = local.nat_instance_name
  assume_role_policy = file("${path.module}/templates/ec2_iam_role.json")

}

resource "aws_iam_policy_attachment" "ec2_ssm" {
  name       = local.nat_instance_name
  roles      = [aws_iam_role.ec2.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_instance_profile" "ec2" {
  name = local.nat_instance_name
  role = aws_iam_role.ec2.name
}

##################
# Security Group #
##################

resource "aws_security_group" "ec2" {
  name        = local.nat_instance_name
  description = "${local.vpc_name} NAT Instance security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = local.nat_instance_name
  }
}

############
# Instance #
############

resource "aws_instance" "nat" {
  ami                         = data.aws_ami.ami.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.tf_public_subnet.id
  associate_public_ip_address = "true"
  source_dest_check           = "false"
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.id
  user_data                   = file("${path.module}/templates/user-data.sh")

  tags = {
    Name = local.nat_instance_name
  }
}

###########
# Outputs #
###########

output "nat_instance_id" {
  value = aws_instance.nat.id
}
