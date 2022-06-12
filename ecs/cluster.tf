resource "aws_ecs_cluster" "cadence_demo_cluster" {
  name = "cadence-demo-cluster"

  capacity_providers = ["FARGATE_SPOT"]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        s3_bucket_name = aws_s3_bucket.log_bucket.id
        s3_key_prefix  = "cadence-cluster-logs"
      }
    }
  }
}

resource "aws_ecs_service" "cadence_demo_service" {
  name    = "cadence-demo-service"
  cluster = aws_ecs_cluster.cadence_demo_cluster.id

  launch_type   = "FARGATE"
  desired_count = 1

  task_definition = aws_ecs_task_definition.cadence_demo_service_task.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.cadence_demo_target_group.arn
    container_name   = "cadence-web"
    container_port   = 8088
  }

  network_configuration {
    security_groups = [aws_security_group.cadence_task_sg.id]
    subnets         = local.subnets
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
}

resource "aws_ecs_task_definition" "cadence_demo_service_task" {
  family                   = "cadence_demo_service_task"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.cadence_task_demo_role.arn
  execution_role_arn       = aws_iam_role.cadence_task_demo_role.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024

  container_definitions = templatefile("${path.root}/ecs/containers/cadence.json.tpl", {
    username           = var.username
    password_arn       = var.password_arn
    log_group          = aws_cloudwatch_log_group.cadence_log.name
    cassandra_endpoint = "${aws_vpc_endpoint.cassandra_endpoint.dns_entry.0.dns_name}:9142"
  })
}