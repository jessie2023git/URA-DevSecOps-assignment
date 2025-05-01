module "ecs_roles" {
  source = "./ecs-role"
  tags = var.tags
}

module "ecs_task_definition" {
  source              = "./ecs-task-definition"
  execution_role_arn  = module.ecs_roles.execution_role_arn
  task_role_arn       = module.ecs_roles.task_role_arn
  repository_name = var.repository_name
  gf_server_root_url = var.gf_server_root_url
  file_system_id = var.file_system_id
  efs_access_point_id = var.efs_access_point_id
  env = var.env
  tags = var.tags
}


module "ecs_service" {
  source            = "./ecs-service"
  service_name      = var.service_name
  cluster           = var.cluster
  task_definition   = module.ecs_task_definition.task_definition_arn
  SubnetIds        = var.SubnetIds
  SecurityGroupIds = var.SecurityGroupIds
  target_group_arn   = var.target_group_arn
  container_name = var.container_name
  tags = var.tags
}