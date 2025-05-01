variable "execution_role_arn" {
  description = "ARN of the ECS execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ECS task definition"
  type        = map(string)
  default     = {}
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
