# ---- CI-safe data sources (disabled in PR CI) ----
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
  # Use synthetic IDs in CI, live lookups locally
  ami_id = var.ci_mode ? "ami-0123456789abcdef0" : data.aws_ami.amazon_linux_2[0].id
  vpc_id = var.ci_mode ? "vpc-0123456789abcdef0" : data.aws_vpc.default[0].id
}
