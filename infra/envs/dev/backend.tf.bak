# Remote state: one bucket + lock table per environment so dev and prod state never mix.
# Create these once (outside this stack) before a real `terraform init`.
# For plan-only review use:  terraform init -backend=false
terraform {
  backend "s3" {
    bucket         = "hotel-tfstate-dev"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "hotel-tf-locks-dev"
    encrypt        = true
  }
}
