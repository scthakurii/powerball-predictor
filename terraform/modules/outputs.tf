output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.powerball_vpc.id
}

output "public_subnets" {
  description = "List of public subnets in the VPC"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "ecs_alb_sg" {
  description = "Security Group ID for ECS and ALB"
  value       = aws_security_group.ecs_alb_sg.id
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.powerball_api_alb.arn
}

output "alb_dns" {
  description = "The DNS name of the ALB"
  value       = aws_lb.powerball_api_alb.dns_name
}

output "alb_target_group_arn" {
  description = "The ARN of the ALB target group"
  value       = aws_lb_target_group.powerball_api_tg.arn
}

output "ecs_cluster_id" {
  description = "The ECS Cluster ID"
  value       = aws_ecs_cluster.powerball_cluster.id
}

output "ecs_task_definition" {
  description = "The ECS Task Definition ARN"
  value       = aws_ecs_task_definition.powerball_api_task.arn
}

output "ecs_service_id" {
  description = "The ECS Service ID"
  value       = aws_ecs_service.powerball_service.id
}

output "s3_bucket_name" {
  description = "The S3 bucket name for storing models"
  value       = aws_s3_bucket.powerball_models.id
}

output "ecs_task_execution_role_arn" {
  description = "IAM Role ARN for ECS Task Execution"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "IAM Role ARN for ECS Task (Model Access)"
  value       = aws_iam_role.ecs_task_role.arn
}

output "alb_role_arn" {
  description = "IAM Role ARN for Application Load Balancer"
  value       = aws_iam_role.alb_role.arn
}

output "frontend_website_url" {
  value = format(
    "http://%s.s3-website-%s.amazonaws.com",
    aws_s3_bucket.frontend_bucket.bucket,
    var.aws_region
  )
}
