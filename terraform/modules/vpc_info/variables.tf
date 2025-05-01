variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "filter_value" {
  description = "Value to be filtered for subnet search"
  type        = list(string)
}