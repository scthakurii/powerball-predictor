# =========================== Step 1: Load Dataset ===========================

import pandas as pd
import numpy as np
from google.colab import drive

# Load the Powerball dataset
file_path = "/content/drive/MyDrive/powerball_powerball.csv"
df = pd.read_csv(file_path)

# Convert date columns to datetime format if available
if {'year', 'month', 'day'}.issubset(df.columns):
    df['date'] = pd.to_datetime(df[['year', 'month', 'day']])
else:
    df['date'] = pd.to_datetime(df['month'], errors='coerce')

# =========================== Step 2: Feature Engineering ===========================

# Time-Weighted Frequencies
decay_factor = 0.95

def compute_time_weighted_freq(column, df, decay_factor):
    time_weighted_freq = {}
    for idx, row in df.iterrows():
        draw_number = row[column]
        weight = decay_factor ** (len(df) - idx)
        time_weighted_freq[draw_number] = time_weighted_freq.get(draw_number, 0) + weight
    return time_weighted_freq

time_weighted_white_ball_freq = {i: compute_time_weighted_freq(f'white_ball_{i}', df, decay_factor) for i in range(1, 6)}
time_weighted_powerball_freq = compute_time_weighted_freq('pb', df, decay_factor)

for i in range(1, 6):
    df[f'wb_{i}_time_weighted_freq'] = df[f'white_ball_{i}'].map(time_weighted_white_ball_freq[i])
df['pb_time_weighted_freq'] = df['pb'].map(time_weighted_powerball_freq)

# Rolling Statistics
window_sizes = [25, 50, 100]
for window in window_sizes:
    for i in range(1, 6):
        df[f'wb_{i}_rolling_mean_{window}'] = df[f'white_ball_{i}'].rolling(window=window, min_periods=1).mean()
    df[f'pb_rolling_mean_{window}'] = df['pb'].rolling(window=window, min_periods=1).mean()

# Recency Bias (Hot/Cold Numbers - Last N Draws)
recent_window = 10  # Last 10 draws
for i in range(1, 6):
    df[f'wb_{i}_recent'] = df[f'white_ball_{i}'].apply(
        lambda x: 1 if x in df.tail(recent_window)[['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5']].values else 0)
df['pb_recent'] = df['pb'].apply(lambda x: 1 if x in df.tail(recent_window)['pb'].values else 0)

# Most Common White Ball Pairs
from itertools import combinations
from collections import Counter

pair_counts = Counter()
for _, row in df.iterrows():
    pairs = list(combinations(row[['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5']], 2))
    pair_counts.update(pairs)

most_common_pairs = {pair: count for pair, count in pair_counts.most_common(15)}
for i in range(1, 5):
    for j in range(i+1, 6):
        col_name = f'wb_pair_{i}_{j}_freq'
        df[col_name] = df.apply(lambda row: most_common_pairs.get((row[f'white_ball_{i}'], row[f'white_ball_{j}']), 0), axis=1)

# Consecutive Draw Matching
def check_consecutive(row, previous_row):
    return any(num in previous_row for num in row[['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5']])

df['prev_draw'] = df[['white_ball_1', 'white_ball_2', 'white_ball_3', 'white_ball_4', 'white_ball_5']].shift(1).apply(tuple, axis=1)
df['consecutive_match'] = df.apply(lambda row: check_consecutive(row, row['prev_draw']) if pd.notna(row['prev_draw']) else False, axis=1)

# Powerball Repeats in Consecutive Draws
df['prev_powerball'] = df['pb'].shift(1)
df['powerball_repeat'] = df['pb'] == df['prev_powerball']

# =========================== 📂 Step 3: Save Processed Data ===========================

processed_file_path = "/mnt/data/processed_data_feature_engineered.csv"
df.drop(columns=['date', 'day', 'month', 'year', 'prev_draw', 'prev_powerball'], errors='ignore', inplace=True)

# Provide file for user to download
# Mount Google Drive
drive.mount('/content/drive')

# Save the file to your Google Drive
df.to_csv("/content/drive/MyDrive/processed_data_feature_engineered.csv", index=False)

print("File saved to Google Drive: /content/drive/MyDrive/processed_data_feature_engineered.csv")