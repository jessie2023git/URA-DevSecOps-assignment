resource "aws_dynamodb_table" "dynamodb_table" {
  name         = var.name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute    = var.attribute

  tags         = var.tags
}