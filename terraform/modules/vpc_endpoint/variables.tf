variable "vpc_id" {
  description = "The ID of the VPC where the endpoint will be created."
  type        = string
}

variable "service_name" {
  description = "The name of the service for the VPC endpoint. Example: 'com.amazonaws.us-east-1.ecr.dkr' for Amazon ECR."
  type        = string
}

variable "subnet_ids" {
  description = "A list of route table IDs to associate with the VPC endpoint."
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the VPC endpoint."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the security group."
  type        = map(string)
  default     = {}
}

variable "is_vpce_gw" {
  description = "A flag used to indicate if VPCE is an Interface endpoint or gateway endpoint"
  type        = number
}