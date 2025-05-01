variable "load_balancer_arn" {
  description = "The ARN of the load balancer."
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate."
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the target group."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
