resource "aws_efs_file_system" "efs" {
  creation_token   = var.efs_name
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
  encrypted        = var.enable_encryption

  tags = var.tags
}

resource "aws_efs_mount_target" "mount" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_group_ids
}

resource "aws_efs_access_point" "root_efs_access_point" {
  file_system_id = aws_efs_file_system.efs.id

  posix_user {
    uid = 0
    gid = 0
  }

  root_directory {
    path = "/"
    creation_info {
      owner_uid   = 0
      owner_gid   = 0
      permissions = "0777"
    }
  }
  
}