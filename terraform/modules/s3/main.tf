resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket

  lifecycle {
    prevent_destroy = true  # Prevent accidental deletion
  }

  versioning {
    enabled = true  # Enable versioning to track state changes
  }

  tags = var.tags
}