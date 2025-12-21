data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "prioritycloudinfra-tf-state"
    key    = "dev-account-alpha/network/terraform.tfstate"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "security" {
  backend = "s3"
  config = {
    bucket = "prioritycloudinfra-tf-state"
    key    = "dev-account-alpha/security/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "ec2" {
  source = "../../../modules/ec2"

  ami_id        = "ami-00ca570c1b6d79f36" # Amazon Linux 2023 (ap-south-1)
  instance_type = "t3.micro"

  subnet_id = data.terraform_remote_state.network.outputs.public_subnets[0]

  security_group_ids = [
    data.terraform_remote_state.security.outputs.security_group_id
  ]

  tags = {
    Name        = "dev-ec2"
    Environment = "dev"
    ManagedBy  = "Terraform"
  }
}
