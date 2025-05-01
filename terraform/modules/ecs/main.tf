resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "disabled"
  }

# Check after service is created
#  service_connect_defaults {
#    namespace = "default"
#  }

  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "ecs_capacity_providers" {
  cluster_name       = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight           = 1
  }
}