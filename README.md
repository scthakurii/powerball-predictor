# powerball-predictor
A glorified random number generator, but a fantastic way to learn ML Engineering! 🚀🎰

## 📖 Project Overview
Let’s be honest—Powerball is purely random. No ML model, no matter how fancy, can truly predict the winning numbers. So why are we doing this?

👉 Because this project is all about hands-on experience in ML Engineering! We use this dataset as a sandbox to practice real-world ML skills, infrastructure automation, deployment, and scaling.

What You’ll Learn
✅ ML Model Training – Feature engineering, hyperparameter tuning, and k-fold validation
✅ AWS Cloud Engineering – ECS (Fargate), S3, Route 53, and ALB deployment
✅ MLOps & CI/CD – Automating model deployment, containerization, and API hosting
✅ Infrastructure as Code (IaC) – Terraform for AWS infra setup
✅ Frontend Deployment – Hosting an S3-powered web app with Route 53

💡 The real prize here isn’t the Powerball jackpot. However it’s mastering these industry-grade ML & DevOps skills!

## 🚀 Project Structure
```
📂 powerball-ml-predictor/
│── 📜 README.md               # This file
│── 📜 requirements.txt         # Python dependencies for API
│── 📜 Dockerfile               # Containerize the Flask API
│── 📂 terraform/               # Infrastructure as Code (Terraform)
│   ├── main.tf                 # Root Terraform file
│   ├── vpc.tf                  # Creates the VPC, subnets, and networking
│   ├── ecs.tf                  # ECS cluster & service
│   ├── alb.tf                  # ALB setup for API
│   ├── s3.tf                   # S3 buckets for models & frontend
│   ├── iam.tf                  # IAM roles and policies
│   ├── variables.tf             # Configurable variables
│   ├── outputs.tf               # Terraform outputs for integration
│── 📂 models/                  # Trained ML models
│   ├── model_powerball.pkl     # Saved ML model powerball only
│   ├── model_white_ball_1.pkl   # Saved ML model whiteball 1 only
│   ├── model_white_ball_2.pkl   # Saved ML model whiteball 2 only
│   ├── model_white_ball_3.pkl   # Saved ML model whiteball 3 only
│   ├── model_white_ball_4.pkl   # Saved ML model whiteball 4 only
│   ├── model_white_ball_5.pkl   # Saved ML model whiteball 5 only
│── 📂 scripts/                 # Deployment scripts
│   ├── build_and_push_ecr.sh    # Build & push Docker image to ECR
│   ├── upload_models_s3.sh      # Upload ML models to S3
│   ├── deploy_frontend_s3.sh    # Deploy frontend to S3
│── 📂 backend/                 # Flask API Backend
│   ├── app.py                  # Main Flask application
│── 📂 frontend/                # S3-hosted Frontend
│   ├── index.html               # UI
│   ├── app.js                   # Fetch predictions from API
│   ├── style.css                # Basic styling
│   ├── assets/
│── 📂 notebooks/               # ML development Jupyter Notebooks
    ├── 01-data-exploration.py  # Exploratory Data Analysis
    ├── 02-feature-engineering.py  # Feature Engineering
    ├── 03-hyperparameter-tuning.py  # Grid Search & Model Selection
    ├── 04-model-training.py  # Final model training

```

