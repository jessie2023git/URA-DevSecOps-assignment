variable "cluster_name" {
  description = "The name of the ECS Cluster"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the ECS Cluster"
  type        = map(string)
  default     = {}
}

