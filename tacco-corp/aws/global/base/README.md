# AWS Global Base

### General

* Description: A module to create the standard resources which will be consumed by all regions in a given AWS account
* Created By: Joe
* Module Dependencies:
  * N/A
* Provider Dependencies:
  * AWS
* Terraform Version: `1.x`


### Usage

* Terraform (basic example):

```hcl
module "global_base" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//tacco-corp/aws/global/base?ref=tc-global-base-v1.0.0"

  env    = "prod"
  domain = "tacoform.com"

}

output "name_servers" {
  description = "the nameservers for your route53 zone"
  value       = module.global_base.name_servers
}

```

* Terraform (alternate example):

```hcl
module "alt_module_name" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/cloudprovider/vm?ref=cloud-resource-v1.0.0"

  env     = "prod"
  service = "burrito"
  size    = "big"
  meat    = "chicken"

}

```

### Options

* Description: Input variable options and Outputs for other modules to consume

#### Inputs

| Variable Name           | Description                        | Options             |  Type  | Required? | Notes |
| :---------------------- | :--------------------------------- | :------------------ | :----: | :-------: | :---- |
| env                     | unique environment name            | test/staging/prod   | string |    Yes    | N/A   |


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
