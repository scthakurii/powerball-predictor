#!/bin/bash

AWS_REGION="us-east-1"
ECR_REPOSITORY="powerball-api"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

echo "🔑 Logging in to Amazon ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

echo "🐳 Building Docker image..."
docker build -t $ECR_REPOSITORY .

echo "🏷️ Tagging image..."
docker tag $ECR_REPOSITORY:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/$ECR_REPOSITORY:latest

echo "🚀 Pushing Docker image to Amazon ECR..."
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/$ECR_REPOSITORY:latest

echo "🔄 Updating ECS Service..."
CLUSTER_NAME="powerball-cluster"
SERVICE_NAME="powerball-api-service"

aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --force-new-deployment

echo "✅ Deployment Complete!"
