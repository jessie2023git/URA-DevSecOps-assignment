variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "proj" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to use"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate."
  type        = string
}

variable "prefix_list_ids" {
  description = "Prefix list will be manually provided if its already created."
  type        = string
  default     = ""
}