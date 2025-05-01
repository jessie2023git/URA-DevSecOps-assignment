resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = var.cluster
  task_definition = var.task_definition
  launch_type     = "FARGATE"
  desired_count   = 2
  scheduling_strategy = "REPLICA"
  platform_version   = "LATEST"
  
  network_configuration {
      subnets          = var.SubnetIds
      security_groups  = var.SecurityGroupIds
      assign_public_ip = false

  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = 3000
  }

  
  deployment_maximum_percent          = 200
  deployment_minimum_healthy_percent  = 100
  deployment_circuit_breaker {
      enable  = true
      rollback = true
  
  }

  deployment_controller {
    type = "ECS"
  }

  enable_ecs_managed_tags = true
  tags = var.tags
}