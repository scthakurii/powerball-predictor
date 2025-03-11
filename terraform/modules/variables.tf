variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "AWS Account ID (auto-retrieved)"
  default     = null # Set to null since it'll be injected dynamically
}

variable "s3_bucket_name" {
  description = "S3 bucket name for storing Powerball models"
  default     = "powerball-model-storage"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "List of public subnets from the VPC"
  type        = list(string)
}

variable "ecs_alb_sg" {
  description = "Security Group ID for ECS tasks & ALB"
  type        = string
}

variable "alb_target_group_arn" {
  description = "Target Group ARN for ALB"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "alb_name" {
  description = "The name of the ALB"
  default     = "powerball-api-alb"
}

variable "alb_listener_port" {
  description = "The port for the ALB listener"
  default     = 80
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = "powerball-cluster"
}

variable "ecs_task_cpu" {
  description = "The amount of CPU to allocate for the ECS task"
  default     = "256"
}

variable "ecs_task_memory" {
  description = "The amount of memory to allocate for the ECS task"
  default     = "512"
}

variable "ecs_task_container_port" {
  description = "The container port for the Powerball API"
  default     = 5000
}

variable "ecs_task_image" {
  description = "Docker image for the Powerball API"
  default     = "YOUR_AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/powerball-api:latest"
}

variable "allowed_ingress_ports" {
  description = "List of allowed ingress ports for the ALB and ECS"
  type        = list(number)
  default     = [80, 5000]
}

variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for ALB & ECS ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "s3_frontend_bucket_name" {
  description = "S3 bucket name for hosting the frontend"
  default     = "powerball-frontend-website"
}
