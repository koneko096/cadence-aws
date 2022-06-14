## Predefined VPC and subnets, customize with your own
locals {
  vpc_id = "vpc-01d67bc62cd3d2d62"
  subnets = [
    "subnet-035f59f5ebeeb1f0f",
    "subnet-01af12079358b9e5e",
  ]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
 
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = "publickey"  ### PLACE PUBLIC KEY HERE ###
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.nano"
  subnet_id       = local.subnets.0
  security_groups = [aws_security_group.worker_sg.id]
  key_name        = aws_key_pair.bastion_key.id
}