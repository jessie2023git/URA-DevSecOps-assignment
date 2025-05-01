
# Create a Route Table for S3 VPC Endpoint
resource "aws_route_table" "s3_route_table" {
  count             = var.is_vpce_gw == 1 ? 1 : 0
  vpc_id = var.vpc_id
  tags = var.tags
}

# Create the S3 Gateway VPC Endpoint
resource "aws_vpc_endpoint" "ecr_vpc_endpoint_gateway" {
  count             = var.is_vpce_gw == 1 ? 1 : 0
  vpc_id       = var.vpc_id
  service_name = var.service_name
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.s3_route_table[count.index].id]
  tags = var.tags
}

# Attach the Route Table to the Subnet for S3 traffic
resource "aws_route_table_association" "s3_route_table_association" {
  count          = var.is_vpce_gw == 1 ?  length(var.subnet_ids) : 0
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.s3_route_table[0].id # since only 1 route_table_id is expected
}

resource "aws_vpc_endpoint" "vpc_endpoint_interface" {
  count             = var.is_vpce_gw == 0 ? 1 : 0
  vpc_id       = var.vpc_id
  service_name = var.service_name
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = var.subnet_ids
  security_group_ids = var.security_group_ids
  tags = var.tags
}