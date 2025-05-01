variable "name" {
  description = "The name of the load balancer"
  type        = string
}

variable "security_groups" {
  description = "A list of security groups to associate with the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets for the load balancer"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the load balancer"
  type        = map(string)
}
