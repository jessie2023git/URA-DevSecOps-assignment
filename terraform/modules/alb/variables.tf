variable "name" {
  description = "The name for the application ALB module."
  type        = string
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the ALB."
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the ALB."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to apply to resources."
  type        = map(string)
}

variable "vpc_id" {
  description = "The VPC ID where the target group will be created."
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for the listener."
  type        = string
}
