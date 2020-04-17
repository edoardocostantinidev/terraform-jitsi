# terraform-jitsi

## How to deploy

### Requirements
* An S3 bucket for backend state. (in this case `jitsi-terraform-state`)
* Terraform version 0.12 and up
### Steps
1) Change the tfvars file with your specific settings
2) terraform init
3) terraform apply

Wait a bit and try to connect to the url that gets printed in output.: