output "vpc_id" {
  value = data.aws_vpc.existing_vpc.id
}

output "vpc_cidr_block" {
  value = data.aws_vpc.existing_vpc.cidr_block
}

output "vpc_tags" {
  value = data.aws_vpc.existing_vpc.tags
}

output "vpc_dhcp_options_id" {
  value = data.aws_vpc.existing_vpc.dhcp_options_id
}

# Output subnet information
output "subnet_ids" {
  value = data.aws_subnets.vpc_application_subnets.ids
}

output "application_subnet_cidr_blocks" {
  value = [for subnet in data.aws_subnet.subnet_details : subnet.cidr_block]
}

output "application_subnet_availability_zones" {
  value = [for subnet in data.aws_subnet.subnet_details : subnet.availability_zone]
}

output "application_subnet_tags" {
  value = [for subnet in data.aws_subnet.subnet_details : subnet.tags]
}
