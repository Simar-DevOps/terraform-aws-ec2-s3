# Terraform: EC2 + S3 (Day 6)

Run:
terraform init
terraform plan  -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
terraform output

Destroy:
terraform destroy -var-file="dev.tfvars"
