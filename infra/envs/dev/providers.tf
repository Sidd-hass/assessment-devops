terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }

  # Plan-only review (plan_only = true): dummy credentials and no AWS API calls, so
  # `terraform plan -refresh=false` works without an AWS account. Set plan_only = false to deploy:
  # credentials then come from the normal AWS chain (env vars, profile, OIDC role).
  access_key                  = var.plan_only ? "dummy" : null
  secret_key                  = var.plan_only ? "dummy" : null
  skip_credentials_validation = var.plan_only
  skip_requesting_account_id  = var.plan_only
  skip_metadata_api_check     = var.plan_only
}
