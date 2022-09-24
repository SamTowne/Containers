# Terraform AWS Bootstrap

This project is to perform the intitial bootstrapping of Terraform in an AWS account. It creates an S3 bucket and DynamoDB Table for Terraform state management using an S3 Remote backend configuration. This is a low-cost, simple way to manage an AWS project using Infrastructure as Code. Using a remote state backend allows for easier collaboration and enables versioning and locking for the terraform state file.

## Prerequisites
- The IAM setup to allow this run to build things in the account is not included, this should be a seperate external step
- The AWS credentials / permissions for Terraform to assume are external to this
- The CICD configuration is external to this module

## Setup Remote State
1. Configure main.tf.
  - Replace all instances of PROJECT_NAME with the name of the project
  - Replace all instances of AWS_ACCOUNT_ID with the AWS Account ID in use
  - Replace all instances of AWS_REGION with the AWS region to deploy to
2. Create the S3 Bucket and Dynamodb locking table.
  - `terraform init`
  - `terraform apply`
3. Switch to S3 remote backend.
  - In main.tf, remove the comments from lines 22-28
  - `terraform init`
  - `terraform apply`

## (Optional) Setup CI-CD using Github Actions
1. Configure `.github/workflows/github-actions.yml` with an AWS region, AWS role, and Role sesison name.
  - aws-region: us-east-1
  - role-to-assume: arn:aws:iam::123456789100:role/my-github-actions-role
  - role-session-name: MySessionName
