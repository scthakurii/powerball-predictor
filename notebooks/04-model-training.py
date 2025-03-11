# =========================== Step 1: Load Feature Engineered Dataset ===========================

import pandas as pd
import numpy as np
import xgboost as xgb
import joblib
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error, mean_squared_error

# Load the dataset after hyperparameter tuning
file_path = "/content/drive/MyDrive/processed_data_feature_engineered.csv"
df = pd.read_csv(file_path)

# Prepare feature set and labels
X = df.drop(columns=['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5', 'pb'])
y_white_balls = df[['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5']]
y_pb = df['pb']

# Split dataset into training and testing sets
X_train, X_test, y_train_white, y_test_white = train_test_split(X, y_white_balls, test_size=0.2, random_state=42)
X_train, X_test, y_train_pb, y_test_pb = train_test_split(X, y_pb, test_size=0.2, random_state=42)

# =========================== Step 2: Train Final XGBoost Models ===========================

# Load best hyperparameters from the previous step
best_params_white = [
    {'n_estimators': 300, 'max_depth': 5, 'learning_rate': 0.05, 'subsample': 1.0, 'colsample_bytree': 1.0, 'reg_lambda': 1.5, 'reg_alpha': 0.1},
    {'n_estimators': 500, 'max_depth': 7, 'learning_rate': 0.05, 'subsample': 0.8, 'colsample_bytree': 1.0, 'reg_lambda': 1, 'reg_alpha': 0},
    {'n_estimators': 300, 'max_depth': 5, 'learning_rate': 0.1, 'subsample': 1.0, 'colsample_bytree': 0.8, 'reg_lambda': 1.5, 'reg_alpha': 0.1},
    {'n_estimators': 500, 'max_depth': 7, 'learning_rate': 0.05, 'subsample': 1.0, 'colsample_bytree': 1.0, 'reg_lambda': 1, 'reg_alpha': 0.1},
    {'n_estimators': 300, 'max_depth': 5, 'learning_rate': 0.1, 'subsample': 0.8, 'colsample_bytree': 1.0, 'reg_lambda': 2, 'reg_alpha': 0.1}
]

best_params_pb = {'n_estimators': 500, 'max_depth': 7, 'learning_rate': 0.05, 'subsample': 1.0, 'colsample_bytree': 1.0, 'reg_lambda': 1, 'reg_alpha': 0.1}

# Train final models for each white ball
white_models = []
for i in range(5):
    print(f"Training final model for White Ball {i+1}...")
    model = xgb.XGBRegressor(objective='reg:squarederror', random_state=42, **best_params_white[i])
    model.fit(X_train, y_train_white.iloc[:, i])
    white_models.append(model)

# Train final model for Powerball
print("Training final model for Powerball...")
pb_model = xgb.XGBRegressor(objective='reg:squarederror', random_state=42, **best_params_pb)
pb_model.fit(X_train, y_train_pb)

# =========================== Step 3: Save Trained Models ===========================
from google.colab import drive

# Define Google Drive path
drive_path = "/content/drive/MyDrive/Powerball_Models/"

# Ensure the directory exists
import os
os.makedirs(drive_path, exist_ok=True)

#for i, model in enumerate(white_models):
#    joblib.dump(model, f"/mnt/data/model_white_ball_{i+1}.pkl")
#
#joblib.dump(pb_model, "/mnt/data/model_powerball.pkl")

# Save each white ball model
for i, model in enumerate(white_models):
    model_path = f"{drive_path}model_white_ball_{i+1}.pkl"
    joblib.dump(model, model_path)
    print(f"Saved: {model_path}")

# Save Powerball model
pb_model_path = f"{drive_path}model_powerball.pkl"
joblib.dump(pb_model, pb_model_path)
print(f"Saved: {pb_model_path}")

# =========================== 🎯 Step 4: Evaluate Final Model ===========================

# Predict and evaluate white balls
y_pred_white = np.column_stack([model.predict(X_test) for model in white_models])
y_pred_pb = pb_model.predict(X_test)

# Round predictions to valid number ranges
y_pred_white = np.clip(np.round(y_pred_white), 1, 69).astype(int)
y_pred_pb = np.clip(np.round(y_pred_pb), 1, 26).astype(int)

# Calculate evaluation metrics
mae_white = mean_absolute_error(y_test_white, y_pred_white)
rmse_white = np.sqrt(mean_squared_error(y_test_white, y_pred_white))
mae_pb = mean_absolute_error(y_test_pb, y_pred_pb)
rmse_pb = np.sqrt(mean_squared_error(y_test_pb, y_pred_pb))

# Display results
final_model_results = {
    "White Balls MAE": mae_white,
    "White Balls RMSE": rmse_white,
    "Powerball MAE": mae_pb,
    "Powerball RMSE": rmse_pb
}

final_model_results
