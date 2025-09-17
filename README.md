\# Terraform: EC2 + S3



\[!\[Terraform CI](https://github.com/Simar-DevOps/terraform-aws-ec2-s3/actions/workflows/terraform.yml/badge.svg)](https://github.com/Simar-DevOps/terraform-aws-ec2-s3/actions/workflows/terraform.yml)



Minimal Terraform project that provisions an EC2 instance and an S3 bucket.  

CI runs \*\*fmt → validate → plan\*\* on pull requests (no apply). The plan is posted in the PR job summary.



---



\## Prerequisites

\- Terraform ≥ 1.6

\- AWS credentials available (via `aws configure` or environment variables)

\- `dev.tfvars` with your values (see `dev.tfvars.example`)



Create your local var file (Windows PowerShell):

```powershell

Copy-Item dev.tfvars.example dev.tfvars



