resource "aws_ecr_repository" "ecr" {
  name = var.name
  image_tag_mutability = "IMMUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
    kms_key  = var.kms_key  
  }
  
  image_scanning_configuration {
  
      scan_on_push = false
  
  }  
  tags = var.tags

  lifecycle {
    ignore_changes = [
      encryption_configuration,   # Ignore changes to encryption settings
      image_scanning_configuration # Ignore changes to image scanning settings
    ]
  }
}