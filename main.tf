# Random suffix to keep bucket names unique
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Get latest Amazon Linux 2 AMI (x86_64) from the official owner
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# --- Networking: Security Group allowing SSH(22) and HTTP(80)
resource "aws_security_group" "web_sg" {
  name        = "tf-day6-web-sg-${random_string.suffix.result}"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "tf-web-sg-${random_string.suffix.result}"
    Project = "Day6"
  }
}

# Lookup default VPC and a public subnet so the instance can get a public IP
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# --- Key Pair: generate an SSH key in Terraform for demo (writes private key to local file)
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "web_key" {
  key_name   = "tf-day6-key-${random_string.suffix.result}"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  filename        = "${path.module}/tf-day6-${random_string.suffix.result}.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"
}

# --- User data: install Nginx and put a simple index page
locals {
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y || yum install -y nginx
    echo "<h1>Hello from Terraform Day 6 🚀</h1>" > /usr/share/nginx/html/index.html
    systemctl enable nginx
    systemctl start nginx
  EOF
}

# EC2 Instance (free tier size) in a public subnet
resource "aws_instance" "my_ec2" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  subnet_id                   = element(data.aws_subnets.default_public_subnets.ids, 0)
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.web_key.key_name
  user_data                   = local.user_data

  tags = {
    Name    = "tf-ec2-${random_string.suffix.result}"
    Project = "Day6"
  }
}

# S3 bucket (private by default)
resource "aws_s3_bucket" "my_bucket" {
  bucket = "simar-tf-${random_string.suffix.result}"

  tags = {
    Name    = "tf-s3-${random_string.suffix.result}"
    Project = "Day6"
  }
}
