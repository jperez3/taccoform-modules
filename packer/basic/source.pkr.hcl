source "amazon-ebs" "linux" {

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]

  }

  ami_name      = local.ami_name
  instance_type = var.instance_type
  region        = var.region
  subnet_id     = var.subnet_id
  vpc_id        = var.vpc_id



  # connection parameters
  communicator                 = var.communicator
  ssh_username                 = var.ssh_username
  ssh_interface                = var.ssh_interface
  iam_instance_profile         = var.iam_instance_profile

  tags = {
    Environment     = var.env
    Name            = local.ami_name
    PackerBuilt     = "true"
    PackerTimestamp = local.timestamp
    Service         = var.service
  }
}
