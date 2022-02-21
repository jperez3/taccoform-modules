

resource "aws_security_group" "jumpbox" {
  count = var.enable_jumpbox_instance ? 1 : 0

  name        = "jumpbox${count.index}-${local.vpc_name}"
  description = "${local.vpc_name} jumpbox instance security group"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "jumpbox${count.index}-${local.vpc_name}"
    })
  )
}

resource "aws_instance" "jumpbox" {
  count = var.enable_jumpbox_instance ? 1 : 0

  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.nat_intance_type
  subnet_id              = aws_subnet.private[count.index].id
  vpc_security_group_ids = [aws_security_group.jumpbox[0].id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.id


  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "jumpbox${count.index}-${local.vpc_name}"
    })
  )
}

output "jumpbox_instance_id" {
  value = var.enable_jumpbox_instance ? aws_instance.jumpbox[0].id : ""
}
