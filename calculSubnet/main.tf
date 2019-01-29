# Configure the AWS Provider and credentials
provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "available" {}

resource "null_resource" "subnets" {
  count = "${local.az_count}"

  triggers {
    # cidr_block              = "${var.bastion_subnets[count.index]}"
    # https://github.com/cloudposse/terraform-aws-dynamic-subnets#subnet-calculation-logic
    # cidr_block = "${signum(length(var.bastion_subnets)) == 1 ? element(concat(var.bastion_subnets, list(""))  ,count.index) : cidrsubnet(data.aws_vpc.current_vpc.cidr_block, ceil(log(local.bastion_subnet_count * 2, 2)), local.bastion_subnet_count + count.index)}"
    private_1_cidr_block = "${cidrsubnet(var.vpc_cidr_block, local.subnet_cidr_newbits, count.index)}"

    # cidr_block              = "${var.bastion_subnets[count.index]}"
    # https://github.com/cloudposse/terraform-aws-dynamic-subnets#subnet-calculation-logic
    # cidr_block = "${signum(length(var.bastion_subnets)) == 1 ? element(concat(var.bastion_subnets, list(""))  ,count.index) : cidrsubnet(data.aws_vpc.current_vpc.cidr_block, ceil(log(local.bastion_subnet_count * 2, 2)), local.bastion_subnet_count + count.index)}"
    private_2_cidr_block = "${cidrsubnet(var.vpc_cidr_block, local.subnet_cidr_newbits, local.az_count + count.index)}"

    # cidr_block              = "${var.bastion_subnets[count.index]}"
    # https://github.com/cloudposse/terraform-aws-dynamic-subnets#subnet-calculation-logic
    # cidr_block = "${signum(length(var.bastion_subnets)) == 1 ? element(concat(var.bastion_subnets, list(""))  ,count.index) : cidrsubnet(data.aws_vpc.current_vpc.cidr_block, ceil(log(local.bastion_subnet_count * 2, 2)), local.bastion_subnet_count + count.index)}"
    public_cidr_block = "${cidrsubnet(var.vpc_cidr_block, local.subnet_cidr_newbits, local.az_count + local.az_count + count.index)}"
  }
}

resource "null_resource" "test" {
  count = "${local.az_count}"

  triggers {
    subnet_id = "${element(null_resource.subnets.*.triggers.private_1_cidr_block, count.index)}"
  }

  depends_on = ["null_resource.subnets"]
}
