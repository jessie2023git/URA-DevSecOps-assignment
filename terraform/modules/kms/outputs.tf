output "kms_key_id" {
  value = aws_kms_key.ecr_kms_key.id
}
