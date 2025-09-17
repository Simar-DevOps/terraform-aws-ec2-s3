# provider.tf
provider "aws" {
  region = var.aws_region
  # CI-only skips so STS/IMDS aren't called on PR plans
  skip_credentials_validation = var.ci_mode
  skip_requesting_account_id  = var.ci_mode
  skip_metadata_api_check     = var.ci_mode
  skip_region_validation      = var.ci_mode
}

