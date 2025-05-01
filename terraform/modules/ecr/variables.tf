variable "name" {
  description = "ECR Repo name"
  type        = string    
}

variable "kms_key" {
  description = "ECR encryption configuration"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the DynamoDB table"
  type        = map(string)
  default     = {}
}