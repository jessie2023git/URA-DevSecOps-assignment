resource "aws_kms_key" "ecr_kms_key" {
  description             = "KMS key for ECR repository encryption"
  enable_key_rotation     = true

  tags = var.tags
}
