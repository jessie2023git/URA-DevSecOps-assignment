output "s3_prefix_list_id" {
  value = length(aws_vpc_endpoint.ecr_vpc_endpoint_gateway) > 0 ? aws_vpc_endpoint.ecr_vpc_endpoint_gateway[0].prefix_list_id : null
}