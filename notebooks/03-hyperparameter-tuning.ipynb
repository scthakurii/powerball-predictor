# =========================== Step 1: Load Processed Dataset ===========================

import pandas as pd
import numpy as np
import xgboost as xgb
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.metrics import mean_absolute_error, mean_squared_error

# Load the feature-engineered dataset
file_path = "/content/drive/MyDrive/processed_data_feature_engineered.csv"
df = pd.read_csv(file_path)

# Prepare feature set and labels
X = df.drop(columns=['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5', 'pb'])
y_white_balls = df[['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5']]
y_pb = df['pb']

# Split dataset into training and testing sets
X_train, X_test, y_train_white, y_test_white = train_test_split(X, y_white_balls, test_size=0.2, random_state=42)
X_train, X_test, y_train_pb, y_test_pb = train_test_split(X, y_pb, test_size=0.2, random_state=42)

# =========================== Step 2: Hyperparameter Tuning with GridSearchCV ===========================

# Define parameter grid for XGBoost
param_grid = {
    'n_estimators': [100, 300, 500],
    'max_depth': [3, 5, 7],
    'learning_rate': [0.01, 0.05, 0.1],
    'subsample': [0.8, 1.0],
    'colsample_bytree': [0.8, 1.0],
    'reg_lambda': [1, 1.5, 2],
    'reg_alpha': [0, 0.1, 0.5]
}

# Function to tune model for each white ball
def tune_xgboost(X_train, y_train):
    model = xgb.XGBRegressor(objective='reg:squarederror', random_state=42)
    grid_search = GridSearchCV(model, param_grid, cv=3, scoring='neg_mean_absolute_error', verbose=1, n_jobs=-1)
    grid_search.fit(X_train, y_train)
    return grid_search.best_estimator_, grid_search.best_params_

# Tune models for each white ball
best_models_white = []
best_params_white = []

for i in range(5):
    print(f"Tuning model for White Ball {i+1}...")
    best_model, best_params = tune_xgboost(X_train, y_train_white.iloc[:, i])
    best_models_white.append(best_model)
    best_params_white.append(best_params)

# Tune model for Powerball
print("Tuning model for Powerball...")
best_model_pb, best_params_pb = tune_xgboost(X_train, y_train_pb)

# =========================== Step 3: Evaluate Tuned Models ===========================

# Predict and evaluate white balls
y_pred_white = np.column_stack([model.predict(X_test) for model in best_models_white])
y_pred_pb = best_model_pb.predict(X_test)

# Round predictions to valid number ranges
y_pred_white = np.clip(np.round(y_pred_white), 1, 69).astype(int)
y_pred_pb = np.clip(np.round(y_pred_pb), 1, 26).astype(int)

# Calculate evaluation metrics
mae_white = mean_absolute_error(y_test_white, y_pred_white)
rmse_white = np.sqrt(mean_squared_error(y_test_white, y_pred_white))
mae_pb = mean_absolute_error(y_test_pb, y_pred_pb)
rmse_pb = np.sqrt(mean_squared_error(y_test_pb, y_pred_pb))

# Display results
tuning_results = {
    "White Balls MAE": mae_white,
    "White Balls RMSE": rmse_white,
    "Powerball MAE": mae_pb,
    "Powerball RMSE": rmse_pb,
    "Best Hyperparameters White Balls": best_params_white,
    "Best Hyperparameters Powerball": best_params_pb
}

print(tuning_results)
