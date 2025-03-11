import os
import joblib
import boto3
from flask import Flask, jsonify
from flask_cors import CORS

# =========================== Flask Setup ===========================

app = Flask(__name__)
CORS(app)  # Allow frontend to call API

# =========================== AWS S3 Config ===========================
S3_BUCKET = "your-bucket-name"  # Change this to your S3 bucket name
MODEL_DIR = "/app/models/"  # Directory inside the container

# Ensure local model directory exists
os.makedirs(MODEL_DIR, exist_ok=True)

# Initialize S3 client
s3_client = boto3.client("s3")

# List of model files
model_files = [
    "model_white_ball_1.pkl",
    "model_white_ball_2.pkl",
    "model_white_ball_3.pkl",
    "model_white_ball_4.pkl",
    "model_white_ball_5.pkl",
    "model_powerball.pkl"
]

# =========================== Download Models from S3 ===========================
def download_models_from_s3():
    for model_file in model_files:
        local_path = os.path.join(MODEL_DIR, model_file)
        s3_key = f"models/{model_file}"  # S3 path

        try:
            print(f"Downloading {model_file} from S3...")
            s3_client.download_file(S3_BUCKET, s3_key, local_path)
            print(f"✅ {model_file} downloaded successfully!")
        except Exception as e:
            print(f"❌ Failed to download {model_file}: {e}")

# Load models
def load_models():
    global models
    models = {file: joblib.load(os.path.join(MODEL_DIR, file)) for file in model_files}
    print("✅ All models loaded successfully!")

# Call functions on startup
download_models_from_s3()
load_models()

# =========================== Prediction API Endpoint ===========================

@app.route('/predict', methods=['GET'])
def predict():
    import numpy as np

    # Select 5 white balls using highest probability white balls
    white_ball_predictions = [
        int(round(models[f"model_white_ball_{i+1}.pkl"].predict([[0]])[0]))  # Replace with real input features
        for i in range(5)
    ]
    white_ball_predictions = sorted(np.clip(white_ball_predictions, 1, 69))  # Ensure valid range

    # Predict Powerball number
    powerball_prediction = int(round(models["model_powerball.pkl"].predict([[0]])[0]))  # Replace with real input
    powerball_prediction = np.clip(powerball_prediction, 1, 26)  # Ensure valid range

    # Response
    response = {
        "White Balls": white_ball_predictions,
        "Powerball": powerball_prediction
    }

    return jsonify(response)

# =========================== Start the Flask App ===========================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
