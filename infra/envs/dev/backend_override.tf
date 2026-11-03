# Plan-only review: overrides the S3 backend in backend.tf with local state, so a plain
# `terraform init` works without AWS. Delete this file to use the real S3 backend.
terraform {
  backend "local" {}
}
