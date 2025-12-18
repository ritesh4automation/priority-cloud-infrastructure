data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "prioritycloudinfra-tf-state"
    key    = "dev-account-alpha/network/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "web_sg" {
  source = "../../../modules/security_groups"

  name   = "dev-web-sg"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = "Dev"
    Service     = "security"
  }
}