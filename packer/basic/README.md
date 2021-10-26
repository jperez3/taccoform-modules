# Packer Basic

### General

* Description: a basic packer example to create an image
* Created By: Joe
* Packer Dependencies:
  * Packer IAM profile with `AmazonSSMManagedInstanceCore` attached to role
  * AWS VPC
* Plugin Dependencies:
  * hashicorp/amazon
* Packer Version: `1.7.x`
* Terraform Version: `1.x.x`

### Pre-flight

1. Create AWS credentials
2. Install and configure awscli
3. Validate awscli configuration: `aws sts get-caller-identity`
4. Install [terraform](https://www.terraform.io/downloads.html)
5. Initialize Terraform: `terraform init`
6. Apply Terraform: `terraform apply`
7. Set VPC ID Packer variable: `export PKR_VAR_vpc_id=$(terraform output -raw vpc_id)`
8. Set VPC Subnet ID Packer variable: `export PKR_VAR_subnet_id=$(terraform output -raw private_subnet_id)`

### Usage


1. Initialize Packer: `packer init plugins.pkr.hcl`
2. Run Packer build: `packer build .`



### Clean Up

1. After testing, clean up terraform resources: `terraform destroy`



### Options

* Description: Input variable options and Outputs for other modules to consume

#### Inputs

| Variable Name           | Description                        | Options             |  Type  | Required? | Notes |
| :---------------------- | :--------------------------------- | :------------------ | :----: | :-------: | :---- |
| env                     | unique environment name            | (default: prod)     | string |    No     | N/A   |
| subnet_id               | Temporary VPC Subnet ID            |                     | string |    Yes    | N/A   |
| vpc_id                  | Temporary VPC ID                   |                     | string |    Yes    | N/A   |


#### Outputs

| Variable Name | Description            |  Type  | Notes |
| :------------ | :--------------------- | :----: | :---- |
| id            | unique id for resource | string | N/A   |

### Lessons Learned

* Stuff
* Goes
* Here


### References

* Stuff
* Goes
* Here
