provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "your-terraform-backend-bucket"
    key    = "powerball-api/terraform.tfstate"
    region = "us-east-1"
  }
}

# Automatically fetch the AWS account ID
data "aws_caller_identity" "current" {}

module "vpc" {
  source = "./vpc.tf"
}

module "s3" {
  source = "./s3.tf"
}

module "iam" {
  source = "./iam.tf"
}

module "alb" {
  source  = "./alb.tf"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  sg_id   = module.vpc.ecs_alb_sg
}

module "ecs" {
  source     = "./ecs.tf"
  vpc_id     = module.vpc.vpc_id
  subnets    = module.vpc.public_subnets
  sg_id      = module.vpc.ecs_alb_sg
  alb_arn    = module.alb.lb_arn
  s3_bucket  = module.s3.bucket_name
}
