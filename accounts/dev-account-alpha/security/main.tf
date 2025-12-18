# Fetch Network outputs dynamically
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "prioritycloudinfra-tf-state"
    key    = "dev-account-alpha/network/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "security" {
  source = "../../../modules/security"

  vpc_id               = data.terraform_remote_state.network.outputs.vpc_id
  security_group_name   = "dev-alpha-app-sg"
  description           = "Security group for dev-account-alpha"

  ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]

  egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
}
