# Terraform AWS Bootstrap

This project is to perform the intitial bootstrapping of Terraform in an AWS account. 

- The IAM setup to allow this run to build things in the account is not included, this should be a seperate external step
- The AWS credentials / permissions for Terraform to assume are external to this module
- The backend should be set to local for the initial apply
- After the state bucket and locking table are created, run a second apply to switch to remote s3 backend