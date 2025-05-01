# Fetch VPC information
data "aws_vpc" "existing_vpc" {
  id = var.vpc_id  # VPC ID passed as an input variable
}

# Fetch subnets within the given VPC
data "aws_subnets" "vpc_application_subnets" {
    filter {
      name   = "vpc-id"
      values = [var.vpc_id]
    }

    filter {
      name   = "tag:Name"
      values = var.filter_value
    }
}

# Fetch subnets within the given VPC
data "aws_subnet" "subnet_details" {
  for_each = toset(data.aws_subnets.vpc_application_subnets.ids)

  id = each.value
}