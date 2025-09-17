# ---- PR plan: avoid live AWS lookups in CI ----
# data sources are disabled when var.ci_mode == true
data "aws_ami" "amazon_linux_2" {
  count       = var.ci_mode ? 0 : 1
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_vpc" "default" {
  count   = var.ci_mode ? 0 : 1
  default = true
}

locals {
  # Fallback IDs only used in CI (synthetic but well-formed)
  ami_id = var.ci_mode ? "ami-0123456789abcdef0" : local.ami_id
  vpc_id = var.ci_mode ? "vpc-0123456789abcdef0" : local.vpc_id
}
