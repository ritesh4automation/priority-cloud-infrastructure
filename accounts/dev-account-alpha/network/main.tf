terraform {
  backend "s3" {
    bucket         = "prioritycloudinfra-tf-state"
    key            = "dev-account-alpha/network/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source         = "../../../modules/vpc"
  region         = "ap-south-1"
  env            = "dev"
  vpc_name       = "dev-alpha-vpc"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs             = ["ap-south-1a", "ap-south-1b"]
  tags = {
    Project = "PriorityCloud"
    Owner   = "Ritesh Pandey"
  }
}
