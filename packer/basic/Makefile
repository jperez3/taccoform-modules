init:
	VPC_ID=$(terraform output -raw vpc_id)
	SUBNET_ID=$(aws ec2 describe-subnets \
	--filters Name=vpc-id,Values=$VPC_ID \
	--query 'Subnets[?MapPublicIpOnLaunch==`false`] | [0].SubnetId' --output text)

packer-init:
	export PKR_VAR_vpc_id=$(terraform output -raw vpc_id)
	export PKR_VAR_subnet_id=$(terraform output -raw private_subnet_id)
