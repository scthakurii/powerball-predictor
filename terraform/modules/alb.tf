resource "aws_lb" "powerball_api_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ecs_alb_sg]   # Uses security group from VPC outputs
  subnets            = var.public_subnets # Uses public subnets from VPC outputs

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "powerball_api_tg" {
  name        = "powerball-api-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id # Uses VPC ID from outputs
  target_type = "ip"

  health_check {
    path                = "/predict"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "powerball-api-target-group"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.powerball_api_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.powerball_api_tg.arn
  }
}
