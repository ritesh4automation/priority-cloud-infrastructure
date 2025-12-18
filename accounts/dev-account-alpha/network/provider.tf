provider "aws" {
  region = var.region

  assume_role {
    role_arn = "arn:aws:iam::223374428235:role/github-actions-oidc-role"
  }
}
