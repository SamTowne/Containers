# Terraform AWS Bootstrap

This project is to perform the intitial bootstrapping of Terraform in an AWS account. It creates an S3 bucket and DynamoDB Table for Terraform state management using an S3 Remote backend configuration. This is a low-cost, simple way to manage an AWS project using Infrastructure as Code.

## Prerequisites
- The IAM setup to allow this run to build things in the account is not included, this should be a seperate external step
- The AWS credentials / permissions for Terraform to assume are external to this
- The CICD configuration is external to this module

## Setup
1. In main.tf on line 2, update `my-project` with your project name.
2. Create the S3 Bucket and Dynamodb locking table.
  - `terraform init`
  - `terraform apply`
3. Switch to S3 remote backend
  - In maint.tf, remove the comments from lines 22-28
  - `terraform init`
  - `terraform apply`