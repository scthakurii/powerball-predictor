# powerball-predictor
A glorified random number generator, but a fantastic way to learn ML Engineering! 🎰

## 📖 Project Overview
Let’s be honest, Powerball is purely random. No ML model, no matter how fancy, can truly predict the winning numbers. So why are we doing this?

👉 Because this project is all about hands-on experience in ML Engineering! We use this dataset as a sandbox to practice real-world ML skills, infrastructure automation, deployment, and scaling.

### What You’ll Learn

- ML Model Training – Feature engineering, hyperparameter tuning, and k-fold validation
- AWS Cloud Engineering – ECS (Fargate), S3, and ALB deployment
- MLOps & CI/CD – Automating model deployment, containerization, and API hosting
- Infrastructure as Code (IaC) – Terraform for AWS infra setup
- Frontend Deployment – Hosting an S3-powered web app

💡 The real prize here isn’t the Powerball jackpot. Although that would be nice. However it’s mastering these industry-grade ML & DevOps skills!

## 🚀 Project Structure
```
📂 powerball-ml-predictor/
│── 📜 README.md               # This file
│── 📜 requirements.txt         # Python dependencies for API
│── 📜 Dockerfile               # Containerize the Flask API
│── 📂 terraform/               # Infrastructure as Code (Terraform)
│   ├── main.tf                 # Root Terraform file
│   ├── variables.tf             # Configurable variables
│── ├──📂 modules/                 # Modules directory
│       ├── vpc.tf                  # Creates the VPC, subnets, and networking
│       ├── ecs.tf                  # ECS cluster & service
│       ├── alb.tf                  # ALB setup for API
│       ├── s3.tf                   # S3 buckets for models & frontend
│       ├── iam.tf                  # IAM roles and policies
│       ├── variables.tf             # Configurable variables
│       ├── outputs.tf               # Terraform outputs for integration
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
│── ├── 📂 assets/
│── 📂 notebooks/               # ML development Jupyter Notebooks
    ├── 01-data-exploration.py  # Exploratory Data Analysis
    ├── 02-feature-engineering.py  # Feature Engineering
    ├── 03-hyperparameter-tuning.py  # Grid Search & Model Selection
    ├── 04-model-training.py  # Final model training
```

## 💡 How It Works
### 🔹 ML Model
- Feature Engineering – Looks at historical Powerball draws for number frequency, hot/cold numbers, and trends.
- Hyperparameter Tuning – Uses GridSearchCV and k-fold validation to optimize XGBoost models.
- Prediction – Generates a set of numbers based on learned patterns (but again, this is just a fancy randomizer).
### 🔹 Backend (Flask API)
- Hosts a /predict endpoint that serves Powerball number predictions using the trained model.
- Packaged into a Docker container and deployed on AWS ECS Fargate.
### 🔹 Frontend (S3 Website)
- Simple UI with a button to fetch predictions from the backend.
- Hosted on AWS S3 (ToDo: Route 53 for a clean domain name).

## Deployment Guide
### Deploy the Infrastructure (Terraform)
```
cd terraform/
terraform init
terraform apply -auto-approve
```

#### This sets up:
- VPC (networking)
- ECS Cluster (backend hosting)
- ALB (load balancer for API)
- S3 Buckets (for models & frontend)

### Train the ML Model (Jupyter Notebook)
```
cd notebooks/
jupyter notebook  # Run model training inside 04-model-training.ipynb
```
Saves the trained model as models/powerball_model.pkl

### Deploy the Backend API (Docker + ECR + ECS)
```
bash scripts/build_and_push_ecr.sh
```

- Builds Docker Image
- Pushes to AWS ECR
- Updates ECS Task with New Image

### Upload ML Models to S3
```
bash scripts/upload_models_s3.sh
```
This moves the trained model pkl files to S3 for API use.

### Deploy Frontend to S3
```
bash scripts/deploy_frontend_s3.sh
```
This syncs the HTML, CSS, and JS files to the S3 frontend bucket.

### Find Your Hosted API & Website
```
terraform output alb_dns
terraform output frontend_website_url
```
- Powerball Prediction API → http://your-alb-url.amazonaws.com/predict
- Frontend UI → http://your-frontend-bucket.s3-website-us-east-1.amazonaws.com

## Features & Best Practices
- Fully Automated AWS Deployment (ECS, S3)
- Infrastructure-as-Code (Terraform)
- Dockerized Flask API
- Machine Learning with XGBoost
- K-Fold Validation & Hyperparameter Tuning
- Scalable Frontend Hosted on AWS S3

## Future Improvements
-  Add Route 53 hosted zone and records for clean domain name
-  Auto-scaling for ECS (Handle high traffic)
-  CloudFront CDN for Faster Frontend Load Times
-  CI/CD Pipeline (GitHub Actions) for auto-deploys
-  Dynamic Localstack/AWS deployment configuration

## Final Thoughts
At the end of the day, this is just a fun experiment to get hands-on with ML Engineering, DevOps, and AWS deployment.
You won’t win the lottery with this, but you will win in your tech career! 🚀

💡 Questions? Suggestions? PRs are welcome! 🎯

## License
MIT License - Use & modify freely! 🚀