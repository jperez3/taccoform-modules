terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.8.1"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.20.0"
    }
  }
}
