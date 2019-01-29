variable "region" {
  default = "eu-central-1"
}

variable "availability_zones" {
  type = "list"

  # default = ["eu-central-1a", "eu-central-1b"]
  default = []
}

//Used by VPC and Bastion module
variable "vpc_cidr_block" {
  default = "10.1.0.0/24"
}

# Nat will be deployed as an ASG between multiple AZs
# With /27 mask, 30 IPs are available for the nat (10 for each AZ)
# variable "subnet_mask" {
#   description = "the network mask number taken to automativally divide NAT subnets (for /27 nat subnets, set '27')"
#   default     = 25
# }

variable tags {
  type = "map"

  default = {
    "Owner"   = "yyy@xxx.com"
    "Contact" = "Surname Name"
  }
}
