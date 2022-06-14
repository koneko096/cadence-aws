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
  region = "ap-southeast-1"
}


module "credentials" {
  source = "./cred"
}

module "db" {
  source = "./cassandra"

  iam_user = module.credentials.iam_user
  username = module.credentials.username
}

resource "aws_ssm_parameter" "keyspace_password" {
  name  = "/cadence-demo/cassandra/password"
  type  = "SecureString"
  value = module.credentials.password
}

module "worker" {
  source = "./ec2"
}

module "server" {
  source = "./ecs"

  username     = module.credentials.username
  password_arn = aws_ssm_parameter.keyspace_password.arn
  worker_sg_id = module.worker.worker_sg_id
}