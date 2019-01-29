# Automatic calculation of subnets CIDR in a VPC on AWS

This code does not create any resource. It simply prints subnet CIDR calculated from a VPC range with the following constraints :

- 1 group of 3 private subnets (1 per AZ) : will host your services on EC2 instances for example
- 1 group of 3 public subnets (1 per AZ) : will host NAT Gateways and Bastion for example
- 1 additionnal group of 3 private subnets (1 per AZ) : will host other services, separated from the previous ones

## Run

export AWS_ACCESS_KEY_ID=<your_key>
export AWS_SECRET_ACCESS_KEY =<your_secret>

terraform fmt && \
terraform init -reconfigure && \
( terraform workspace new test || true ) && \
terraform workspace select test && \
terraform plan -out plan.out && \
terraform apply "plan.out"

## Ouput example

