


data "aws_ecr_image" "latest_image" {
  repository_name = var.repository_name
  most_recent       = true
}

resource "aws_ecs_task_definition" "application_task" {
  family                = "application-${var.env}-task-definition"
  execution_role_arn    = var.execution_role_arn
  task_role_arn         = var.task_role_arn
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "2048"
  memory                = "10240"

  container_definitions = jsonencode([
        {
            "name": "application-${var.env}-app",
            "image": data.aws_ecr_image.latest_image.image_uri,
                     
            "cpu": 0,
            "portMappings": [
                {
                    "name": "application-${var.env}-tcp",
                    "containerPort": 3000,
                    "hostPort": 3000,
                    "protocol": "tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [
                {
                    "name": "user",
                    "value": "472"
                },
                {
                    "name": "GF_SERVER_ROOT_URL",
                    "value": var.gf_server_root_url
                }
            ],
            "environmentFiles": [],
            "mountPoints": [
                {
                    "sourceVolume": "application-${var.env}-volume",
                    "containerPath": "/var/lib/application",
                    "readOnly": false
                }
            ],
            "volumesFrom": [],
            "ulimits": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/application-${var.env}-task-definition",
                    "mode": "non-blocking",
                    "awslogs-create-group": "true",
                    "max-buffer-size": "25m",
                    "awslogs-region": "ap-southeast-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
        }
    ])

  volume {
    name = "application-${var.env}-volume"

    efs_volume_configuration {
      file_system_id          = var.file_system_id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2049
      authorization_config {
        access_point_id = var.efs_access_point_id
        iam             = "ENABLED"
      }
    }
  }

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }  
  tags = var.tags
}

