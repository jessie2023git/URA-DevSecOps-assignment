variable "name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "The billing mode of the DynamoDB table (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
}

variable "attribute" {
  description = "List of attribute definitions for the table"
  type        = list(object({
    name = string
    type = string
  }))
}

variable "tags" {
  description = "Tags to assign to the DynamoDB table"
  type        = map(string)
  default     = {}
}