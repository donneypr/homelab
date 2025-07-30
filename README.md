stuff for my homelab

commands used:

terraform/ 

terraform init <- init working dir, install provider, creates tf binaries

terraform plan -var-file="secrets.tfvars"  <- pre stage for terraform apply, uses vars in secrets.tfvars

terraform apply -var-file="secrets.tfvars"  <- executes tf code to infrastructure 

