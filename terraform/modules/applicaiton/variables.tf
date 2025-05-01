variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "cluster" {
  description = "The name or ARN of the ECS cluster"
  type        = string
}

variable "SubnetIds" {
  description = "A list of subnet IDs to associate with the ECS service"
  type        = list(string)
}

variable "SecurityGroupIds" {
  description = "A list of security group IDs to associate with the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "The ARN of the target group for the ECS service"
  type        = string
}

variable "container_name" {
  description = "The name of the container in the ECS task definition"
  type        = string
}

variable "repository_name" {
  description = "ECR Repository name"
  type        = string
}

variable "gf_server_root_url" {
  description = "application Root URL"
  type        = string
}

variable "file_system_id" {
  description = "EFS ID"
  type        = string
}

variable "efs_access_point_id" {
  description = "EFS access point ID"
  type        = string
}

variable "env" {
  description = "Environment the resource is deployed"
  type        = string
}