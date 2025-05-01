variable "efs_name" {
  description = "The name used for the EFS file system and its tag."
  type        = string
}

variable "performance_mode" {
  description = "The performance mode for the EFS file system. Valid values are 'generalPurpose' or 'maxIO'."
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "The throughput mode for the EFS file system. Valid values are 'bursting' or 'provisioned'."
  type        = string
  default     = "bursting"
}

variable "enable_encryption" {
  description = "Whether encryption is enabled for the EFS file system. Set to true to enable encryption, false to disable."
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the EFS mount targets will be created."
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the EFS mount targets."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the KMS key"
  type        = map(string)
  default     = {}  # Default to an empty map if no tags are provided
}