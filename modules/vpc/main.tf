provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  # IGW automatically created for public subnets
  enable_nat_gateway = false

  tags = merge(
    {
      "Environment" = var.env
      "CreatedBy"   = "Terraform"
    },
    var.tags
  )
}
