# Terraform AWS Bootstrap

This project is to perform the intitial bootstrapping of Terraform in an AWS account. 

- The IAM setup to allow this run to build things in the account is not included, this should be a seperate external step
- The AWS credentials are external and should be managed outside of this module (export locally, or use an external vault for credential reads)
- The backend should be set to local for the initial apply
- After the state bucket and locking table are created, run a second apply to switch to remote s3 backend