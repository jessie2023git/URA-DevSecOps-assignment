variable "vpc_id" {
  description = "The VPC ID where the target group will be created"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the target group"
  type        = map(string)
  default     = {}
}
