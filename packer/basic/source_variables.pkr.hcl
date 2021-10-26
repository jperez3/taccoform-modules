#####################
# General Variables #
#####################

variable "instance_type" {
    description = "instance type for packer build"
    default     = "t3.micro"
}

#####################
# AWS VPC Variables #
#####################

variable "vpc_id" {
    description = "vpc ID for instance creation"
}

variable "subnet_id" {
    description  = "subnet ID for instance creation"
}

variable "communicator" {
    description  = "communication method used for instance"
    default      = "ssh"
}

variable "ssh_username" {
    description = "ssh username for packer to use for provisioning"
    default     = "ec2-user"
}
