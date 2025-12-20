module "vpc" {
  source = "../../../modules/vpc"

  cidr = "10.10.0.0/16"

  public_subnets = [
    "10.10.1.0/24",
    "10.10.2.0/24",
     "10.10.3.0/24" 
  ]

  azs = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]

  tags = {
    Environment = "dev"
    Account     = "dev-account-alpha"
    ManagedBy   = "RiteshTerraform"
  }
}
