terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-1"
}


module "credentials" {
  source = "./cred"
}

module "db" {
  source = "./cassandra"
  
  iam_user = module.credentials.iam_user
  username = module.credentials.username
}