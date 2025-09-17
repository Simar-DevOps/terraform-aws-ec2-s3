# variables.tf
variable "aws_region" {
  type        = string
  default     = "us-east-1" # safe default for CI dry-run
  description = "AWS region"
}

variable "ci_mode" {
  type        = bool
  default     = false # true only in CI to skip AWS checks
  description = "Skip AWS auth/region/account checks in CI"
}

