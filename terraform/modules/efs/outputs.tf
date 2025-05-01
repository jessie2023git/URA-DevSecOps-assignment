# modules/efs/outputs.tf
output "efs_id" {
  value = aws_efs_file_system.efs.id
}

output "efs_access_point_id" {
  description = "The ID of the EFS access point"
  value       = aws_efs_access_point.root_efs_access_point.id
}

