terraform {
  backend "s3" {
    bucket         = "simar-tfstate-935271781612-us-east-1-625982245"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks"
    encrypt        = true
  }
}
# ci-trigger 2025-09-21T16:31:55.4120533-04:00
