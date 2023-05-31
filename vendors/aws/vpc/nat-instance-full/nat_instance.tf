#######
# IAM #
#######

resource "aws_iam_role" "ec2" {
  name               = local.nat_instance_name
  assume_role_policy = file("${path.module}/files/ec2_iam_role.json")

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.nat_instance_name
    })
  )

}

resource "aws_iam_policy_attachment" "ec2_ssm" {
  name       = local.nat_instance_name
  roles      = [aws_iam_role.ec2.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_instance_profile" "ec2" {
  name = local.nat_instance_name
  role = aws_iam_role.ec2.name

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.nat_instance_name
    })
  )
}

##################
# Security Group #
##################

resource "aws_security_group" "ec2" {
  name        = local.nat_instance_name
  description = "${local.vpc_name} NAT Instance security group"
  vpc_id      = aws_vpc.current.id

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

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = local.nat_instance_name
    })
  )
}

############
# Instance #
############

resource "aws_instance" "nat" {
  count = var.nat_instance_count

  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.nat_intance_type
  subnet_id                   = aws_subnet.public[count.index].id
  associate_public_ip_address = "true"
  source_dest_check           = "false"
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.id
  user_data                   = file("${path.module}/files/user-data.sh")

  lifecycle {
    create_before_destroy = true
  }


  # Script to give NAT Instance time to wake up
  provisioner "local-exec" {
    command = "./${path.module}/files/check_instance_state.sh ${self.id}"
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "nat${count.index}-${local.vpc_name}"
    })
  )
}

###########
# Outputs #
###########

output "nat_instance_ids" {
  value = aws_instance.nat[*].id
}
