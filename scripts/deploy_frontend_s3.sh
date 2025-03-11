#!/bin/bash

# =========================== 🌍 Set AWS Variables ===========================
AWS_REGION="us-east-1"
S3_BUCKET="powerball-frontend-website"
FRONTEND_DIR="frontend"

# =========================== 📤 Upload Frontend Files ===========================
echo "🚀 Deploying Frontend to S3..."
aws s3 sync $FRONTEND_DIR s3://$S3_BUCKET/ --acl public-read

echo "✅ Frontend Deployed Successfully!"
echo "🌍 Website URL: http://$S3_BUCKET.s3-website-$AWS_REGION.amazonaws.com"
