terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.5.0"
}

# Allow overriding the AWS profile in CI/CD
variable "aws_profile" {
  type    = string
  default = "simar-dev"
}

# Toggle for CI so provider doesn't try to talk to AWS
variable "ci_mode" {
  type    = bool
  default = false
}

provider "aws" {
  # Use the local profile normally; disable it in CI by passing aws_profile="ignore"
  profile = var.aws_profile != "ignore" ? var.aws_profile : null
  region  = "us-east-1"

  # In CI, skip all AWS checks so no API calls happen
  skip_credentials_validation = var.ci_mode
  skip_requesting_account_id  = var.ci_mode
  skip_region_validation      = var.ci_mode
  skip_metadata_api_check     = var.ci_mode
}
