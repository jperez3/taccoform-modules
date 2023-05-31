# Module Name

### General

* Description:
* Created By:
* Module Dependencies:
  * Stuff
  * Goes
  * Here
* Provider Dependencies:
  * Stuff
  * Goes
  * Here
* Terraform Version:


### Usage

* Terraform (basic example):

```hcl
module "module_name" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/cloudprovider/vm?ref=cloud-vm-v1.0.0"

  env     = "prod"
  service = "burrito"

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
