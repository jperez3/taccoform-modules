# VPC + NAT Instance Module

### General

- Description: A low cost (and opinionated) VPC creation module for developers to use for building proof of concepts
- Created by: Joe Perez
- Module Dependencies:
  - N/A
- Module Components:
  - AWS VPC
  - NAT Instance (x2)
- Provider Dependencies:
  - `hashicorp/aws`
- Terraform Version: `1.x.x`

### Usage

#### Terraform (basic)

```hcl

module "vpc" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/aws/vpc/nat-instance?ref=vndr-aws-vpc-ni-v1.0.0"

  env = "prod"

  cidr_block = "10.45.0.0"
}
```

- Creates a VPC with:
  - name: `main-prod`
  - CIDR: `10.45.0.0/16`
  - Private Subnets: `10.45.0.0/19` + `10.45.32.0/19`
  - Public Subnets: `10.45.64.0/20` + `10.45.80.0/20`

#### Terraform (custom)

```hcl

module "vpc" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/aws/vpc/nat-instance?ref=vndr-aws-vpc-ni-v1.0.0"

  env = "prod"

  custom_vpc_name         = "tacos-por-favor"
  cidr_block              = "10.45.0.0"
  enable_jumpbox_instance = true
}
```

- Creates a VPC with:
  - name: `tacos-por-favor`
  - CIDR: `10.45.0.0/16`
  - Private Subnets: `10.45.0.0/19` + `10.45.32.0/19`
  - Public Subnets: `10.45.64.0/20` + `10.45.80.0/20`
  - Enables jumpbox instance with Session Manager enabled to validate/troubleshoot NAT Instance connectivity

#### Terraform (minimal)

```hcl

module "vpc" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/aws/vpc/nat-instance?ref=vndr-aws-vpc-ni-v1.0.0"

  env = "prod"
}
```

- Creates a VPC with:
  - name: `main-prod`
  - CIDR: `10.123.0.0/16`
  - Private Subnets: `10.123.0.0/19` + `10.123.32.0/19`
  - Public Subnets: `10.123.64.0/20` + `10.123.80.0/20`

#### Inputs

| Variable Name           | Description                                     | Options                       |  Type   | Required? | Notes |
| :---------------------- | :---------------------------------------------- | :---------------------------- | :-----: | :-------: | :---- |
| custom_vpc_name         | override existing vpc name format               |                               | string  |    No     | N/A   |
| cidr_block              | a network to assign to the VPC                  | (default: `10.123.0.0`)       | string  |    No     | N/A   |
| enable_jumpbox_instance | enable jumpbox/ssm instance for troubleshooting | true/false (default: `false`) | boolean |    No     | N/A   |
| env                     | unique environment name                         | test/staging/prod             | string  |    Yes    | N/A   |
| vpc_name_prefix         | name prefix assigned to VPC                     | (default: `main`)             | string  |    No     | N/A   |

#### Outputs

| Variable Name      | Description        |  Type  | Notes |
| :----------------- | :----------------- | :----: | :---- |
| nat_instance_id    | NAT Instance IDs   |  list  | N/A   |
| private_subnet_ids | Private Subnet IDs |  list  | N/A   |
| public_subnet_ids  | Public Subnet IDs  |  list  | N/A   |
| vpc_id             | VPC ID             | string | N/A   |

### Lessons Learned

- `t3a.nano` seems to be the current cheapest/decent instance size to use. Setting up cost savings in AWS Billing can make them even cheaper
- Using two AZs, each mapped to their own NAT instance to minimize cross AZ network cost

### References

- [Cost Saving with NAT Instances](https://www.kabisa.nl/tech/cost-saving-with-nat-instances/)
- [Disgruntled Terraform Examples](https://github.com/Disgruntled/terraform_examples)
- [Practical VPC Design](https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc)
- [Taccoform](https://www.taccoform.com)
- [Terraform Variable Validation](https://medium.com/codex/terraform-variable-validation-b9b3e7eddd79)
- [Zero Downtime Update with Terraform](https://www.hashicorp.com/blog/zero-downtime-updates-with-terraform)
