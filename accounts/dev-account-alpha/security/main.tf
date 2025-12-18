data "terraform_remote_state" "network" {
backend = "s3"


config = {
bucket = "prioritycloudinfra-tf-state"
key = "dev-account-alpha/network/terraform.tfstate"
region = "ap-south-1"
}
}


resource "aws_security_group" "web" {
name = "dev-web-sg"
vpc_id = data.terraform_remote_state.network.outputs.vpc_id


ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}


tags = {
Environment = "dev"
Service = "security"
}
}