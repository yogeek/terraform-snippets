output "AWS_AZs" {
  value = "${data.aws_availability_zones.available.names}"
}

output "maximum subnet size" {
  value = "${local.vpc_cidr_mask + local.subnet_cidr_newbits}"
}

output "use_AZs" {
  value = "${var.availability_zones}"
}

output "az_count" {
  value = "${local.az_count}"
}

output "priv_1_subnets" {
  value = "${null_resource.subnets.*.triggers.private_1_cidr_block}"
}

output "priv_2_subnets" {
  value = "${null_resource.subnets.*.triggers.private_2_cidr_block}"
}

output "public_subnets" {
  value = "${null_resource.subnets.*.triggers.public_cidr_block}"
}

output "test" {
  value = "${null_resource.test.*.triggers.subnet_id}"
}
