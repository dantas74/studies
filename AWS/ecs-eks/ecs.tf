resource "aws_ecs_cluster" "this" {
  name = "demo-clu"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_capacity_provider" "this" {
  name = "this-cprv"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.this.arn
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = [aws_ecs_capacity_provider.this.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.this.name
    base              = 1
    weight            = 200
  }
}

resource "aws_ecs_task_definition" "this" {
  family             = "demo-td"
  execution_role_arn = "ecsTaskExecutionRole"
  task_role_arn      = "ecsTaskExecutionRole"

  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["EC2"]

  network_mode          = "host"
  container_definitions = <<EOF
[
  {
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/demo-td",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "image": "nginx:stable-alpine",
    "essential": true,
    "name": "web"
  }
]
EOF
}

resource "aws_ecs_service" "this" {
  name                   = "demo-srv"
  cluster                = aws_ecs_cluster.this.id
  task_definition        = aws_ecs_task_definition.this.arn
  desired_count          = 1
  enable_execute_command = true
  force_new_deployment   = true
  scheduling_strategy    = "REPLICA"

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.this.name
    base              = 1
    weight            = 200
  }

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "web"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}
