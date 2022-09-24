# Quick setup:
#  1. Replace all instances of PROJECT_NAME with the name of the project
#  2. Replace all instances of AWS_ACCOUNT_ID with the AWS Account ID in use
#  3. Replace all instances of AWS_REGION with the AWS region to deploy to

#################
### Bootstrap ###
#################

# Build an S3 bucket and DynamoDB for Terraform state and locking
module "bootstrap" {
  source         = "./modules/bootstrap"
  project_prefix = "PROJECT_NAME-AWS_ACCOUNT_ID"
}

# Build the IAM needed for github actions CICD
# **IMPORTANT** Configuring this part incorrectly can compromise your AWS account, don't touch this unless you are comfortable with OIDC and federation concepts.
# module "github-actions-iam" {
#   source           = "./modules/github-actions-iam"
#   project_prefix   = "PROJECT_NAME-AWS_ACCOUNT_ID"
#   github_workspace = "UPDATE TO YOUR GITHUB WORKSPACE NAME"
#   github_repo      = "UPDATE TO YOUR GITHUB REPO NAME"
# }

############################
### Terraform S3 Backend ###
############################
# This should be commented out for the first terraform apply so that the tfstate bucket and locking table can be built. After the initial apply, uncomment the s3 backend code and run another apply.
terraform {
  #   backend "s3" {
  #     bucket         = "PROJECT_NAME-AWS_ACCOUNT_ID-terraform-tfstate"
  #     key            = "terraform.tfstate"
  #     region         = "AWS_REGION"
  #     dynamodb_table = "PROJECT_NAME-AWS_ACCOUNT_ID-dynamodb-terraform-locking"
  #     encrypt        = true
  #   }
}

#################
### Providers ###
#################

# Credentials are exported or retrieve from an external store like Hashicorp Vault

provider "aws" {
  region = "AWS_REGION"

  default_tags {
    tags = {
      Terraform = "true"
      Project   = "PROJECT_NAME"
    }
  }
}