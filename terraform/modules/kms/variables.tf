# variables.tf

# Define the tags variable that will be passed to resources
variable "tags" {
  description = "A map of tags to assign to the KMS key"
  type        = map(string)
  default     = {}  # Default to an empty map if no tags are provided
}
