output "vpc_id" {
  value = module.vpc_info.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc_info.vpc_cidr_block
}

output "vpc_tags" {
  value = module.vpc_info.vpc_tags
}

output "vpc_dhcp_options_id" {
  value = module.vpc_info.vpc_dhcp_options_id
}

output "subnet_ids" {
  value = module.vpc_info.subnet_ids
}

output "subnet_cidr_blocks" {
  value = module.vpc_info.application_subnet_cidr_blocks
}

output "subnet_availability_zones" {
  value = module.vpc_info.application_subnet_availability_zones
}

output "subnet_tags" {
  value = module.vpc_info.application_subnet_tags
}

output "cluster_id" {
  value = module.ecs.cluster_id
}

output "ecs_security_group_id" {
  value = module.security_group_ecs_service.security_group_id
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "ecr_repository_name" {
  value = module.ecr.ecr_repository_name
}

output "efs_id" {
  value = module.efs.efs_id
}

output "efs_access_point_id" {
  value = module.efs.efs_access_point_id
}
