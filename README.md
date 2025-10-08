# Terraform: EC2 + S3

[![Terraform CI](https://img.shields.io/github/actions/workflow/status/Simar-DevOps/terraform-aws-ec2-s3/terraform.yml?label=Terraform%20CI&logo=github-actions)](https://github.com/Simar-DevOps/terraform-aws-ec2-s3/actions)
[![License](https://img.shields.io/badge/License-MIT-informational)](LICENSE)

Minimal Terraform project that provisions an **EC2 instance** and an **S3 bucket**.

> **CI Auth:** GitHub Actions uses **OIDC** (short-lived creds; no long-lived AWS keys). See `.github/workflows/terraform.yml`.

---

## What this repo demonstrates

- **IaC** with Terraform: EC2 + S3, tagged, secure SG (SSH from my IP; HTTP/HTTPS open).
- **Remote backend**: S3 state + DynamoDB locking (`tf-locks`).
- **CI/CD**:
  - **PRs:** `fmt → validate → plan` (no apply). Plan is visible in the job logs.
  - **main:** gated **apply** via GitHub **Environment** (`prod`) manual approval.
  - **Auth:** GitHub OIDC → AWS IAM role (`github-oidc-terraform`). No access keys.

---

## Inputs
| Name             | Type   | Example      | Description                         |
|------------------|--------|--------------|-------------------------------------|
| `region`         | string | `us-east-1`  | AWS region                          |
| `project_prefix` | string | `simar`      | Prefix for names/tags               |
| `allowed_ssh_ip` | string | `1.2.3.4/32` | IP/CIDR permitted for SSH           |

---

## Prerequisites

- Terraform ≥ **1.6**
- AWS CLI v2 configured locally (for manual runs)  
- An S3 bucket for state and a DynamoDB table for locks (this repo expects `tf-locks`)

---

## Quick start (local)

**Windows PowerShell**

```powershell
# clone
git clone https://github.com/Simar-DevOps/terraform-aws-ec2-s3.git
cd terraform-aws-ec2-s3

# create your local var file from the example
Copy-Item dev.tfvars.example dev.tfvars

# edit your values (AMI, key name, CIDR for SSH, etc.)
notepad dev.tfvars

# init/plan/apply locally (uses your local AWS CLI credentials)
terraform init -input=false
terraform validate
terraform plan -var-file="dev.tfvars"
terraform apply -auto-approve -var-file="dev.tfvars"

