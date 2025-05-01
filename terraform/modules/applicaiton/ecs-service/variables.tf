variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "cluster" {
  description = "ARN or name of the ECS cluster"
  type        = string
}

variable "task_definition" {
  description = "ARN or family of the task definition"
  type        = string
}

variable "SubnetIds" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "SecurityGroupIds" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group for the load balancer"
  type        = string
}

variable "container_name" {
  description = "Name of the container to associate with the load balancer"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ECS service"
  type        = map(string)
}
