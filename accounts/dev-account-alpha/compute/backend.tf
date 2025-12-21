terraform {
  backend "s3" {
    bucket         = "prioritycloudinfra-tf-state"
    key            = "dev-account-alpha/compute/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
