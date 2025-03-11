#!/bin/bash

# =========================== 🌍 Set AWS Variables ===========================
AWS_REGION="us-east-1"
S3_BUCKET="powerball-model-storage"
MODEL_DIR="models"

# =========================== 📤 Upload Models to S3 ===========================
echo "📤 Uploading models to S3..."
aws s3 cp $MODEL_DIR s3://$S3_BUCKET/models/ --recursive

echo "✅ Models Uploaded Successfully!"
