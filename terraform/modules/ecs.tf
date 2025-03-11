data "aws_caller_identity" "current" {}

resource "aws_ecs_cluster" "powerball_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "powerball_api_task" {
  family                   = "powerball-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "powerball-api"
    image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/powerball-api:latest"
    essential = true
    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
    }]
    environment = [
      { name = "S3_BUCKET", value = var.s3_bucket_name }
    ]
  }])
}

resource "aws_ecs_service" "powerball_service" {
  name            = "powerball-api-service"
  cluster         = aws_ecs_cluster.powerball_cluster.id
  task_definition = aws_ecs_task_definition.powerball_api_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnets
    assign_public_ip = true
    security_groups  = [var.ecs_alb_sg]
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "powerball-api"
    container_port   = 5000
  }
}