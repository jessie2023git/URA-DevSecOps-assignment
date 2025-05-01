variable "name" {
  description = "The name of the security group."
  type        = string
}

variable "description" {
  description = "A brief description of the security group."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created."
  type        = string
}


variable "tags" {
  description = "A map of tags to assign to the security group."
  type        = map(string)
  default     = {}
}

variable "ingress_rules" {
  type = list(object({
    from_port                 = number
    to_port                   = number
    protocol                  = string
    cidr                      = optional(list(string))
    source_security_group_id  = optional(string) 
    prefix_list_ids           = optional(list(string))
  }))
  default = [
  ]
}

variable "egress_rules" {
  type = list(object({
    from_port                 = number
    to_port                   = number
    protocol                  = string
    cidr                      = optional(list(string))
    source_security_group_id  = optional(string)
    prefix_list_ids           = optional(list(string))
  }))
  default = [
  ]
}