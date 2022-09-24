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
    - In main.tf, remove the comments from the bootstrap module
    - `terraform init`
    - `terraform apply`

## (Optional) Setup CI-CD using Github Actions
**WARNING misconfiguration during these steps can compromise your AWS account. Do not proceed unless you are absolutely certain that the input values you are providing to github-actions-iam module are correct.**
1. Set up the github-actions-iam module.
    - In main.tf, remove the comments from the github-actions-iam module
    - Set the github_workspace variable to the github workspace name. e.g.:, If https://github.com/SamTowne/TerraformAWSBootstrap is the repo URL, set as `SamTowne`
  - Set the github_repo variable to the github repository name. e.g.: If https://github.com/SamTowne/TerraformAWSBootstrap is the repo URL, set as `TerraformAWSBootstrap`
2. Configure `.github/workflows/github-actions.yml` with an AWS region, AWS role, and Role session name.
    - aws-region: us-east-1
    - role-to-assume: arn:aws:iam::AWS_ACCOUNT_ID:role/PROJECT_NAME-AWS_ACCOUNT_ID-github-oidc
      - this should be the role that is being created at ./modules/github-actions-iam/iam.tf