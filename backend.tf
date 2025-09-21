terraform {
  backend "s3" {
    bucket         = "simar-tfstate-935271781612-us-east-1-625982245"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks"
    encrypt        = true
  }
}
