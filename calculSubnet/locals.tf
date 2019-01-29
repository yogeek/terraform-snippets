locals {
  az_count = "${signum(length(var.availability_zones)) == 1 ? length(var.availability_zones) : length(data.aws_availability_zones.available.names)}"

  vpc_cidr_mask = "${element(split("/",var.vpc_cidr_block),1)}"

  # 'newbits' for nat subnets
  # newbits number specifies how many subnets the CIDR block (VPC) will be divided into
  # e.g. : to divide a VPC range "10.47.225.0/24" in "/27" subnets, the newbits is "3" (27-24)
  # https://www.terraform.io/docs/configuration/interpolation.html#cidrsubnet-iprange-newbits-netnum-
  subnet_cidr_newbits = "${ceil(log(local.az_count * 3, 2))}"
}
