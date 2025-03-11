#provider "aws" {
#  region = var.aws_region
#}

#terraform {
#  backend "s3" {
#    bucket = "your-terraform-backend-bucket"
#    key    = "powerball-api/terraform.tfstate"
#    region = "us-east-1"
#  }
#}
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true

  dynamic "endpoints" {
    for_each = var.use_localstack ? [1] : []

    content {
      s3             = "http://localhost:4566"
      ec2            = "http://localhost:4566"
      sts            = "http://localhost:4566"
      iam            = "http://localhost:4566"
      lambda         = "http://localhost:4566"
      dynamodb       = "http://localhost:4566"
      cloudwatch     = "http://localhost:4566"
      apigateway     = "http://localhost:4566"
      sns            = "http://localhost:4566"
      sqs            = "http://localhost:4566"
      route53        = "http://localhost:4566"
      cloudformation = "http://localhost:4566"
    }
  }
}

# Automatically fetch the AWS account ID
data "aws_caller_identity" "current" {}

#module "vpc" {
#  source = "./modules"
#}
#
#module "s3" {
#  source = "./modules"
#}
#
#module "iam" {
#  source = "./modules"
#}
#
#module "alb" {
#  source  = "./modules"
#  vpc_id  = module.vpc.vpc_id
#  subnets = module.vpc.public_subnets
#  sg_id   = module.vpc.ecs_alb_sg
#}
#
#module "ecs" {
#  source    = "./modules"
#  vpc_id    = module.vpc.vpc_id
#  subnets   = module.vpc.public_subnets
#  sg_id     = module.vpc.ecs_alb_sg
#  alb_target_group_arn = module.alb.alb_target_group_arn
#  s3_bucket = module.s3.bucket_name
#}

module "infrastructure" {
  source = "./modules"

  vpc_id               = module.infrastructure.vpc_id
  ecs_alb_sg           = module.infrastructure.ecs_alb_sg
  public_subnets       = module.infrastructure.public_subnets
  alb_target_group_arn = module.infrastructure.alb_target_group_arn
}

