# Jakarta Traffic Analysis (Optimized Pipeline)

This repository contains an end-to-end data processing and machine learning pipeline for analyzing and predicting vehicle speeds in Jakarta. The pipeline uses **PySpark** for data ingestion, cleaning, joins, aggregations, SQL-based EDA, and Parquet ETL, and **Scikit-Learn/XGBoost** for training a multi-model regression comparison suite.

![Pipeline Architecture](docs/project_architecture.png)

---

## Key Features & Optimizations

* **Join-Key Resolution**: Documents and explicitly resolves a data quality discrepancy where the road networks and sensor data do not share matching keys.
* **Target Leakage Prevention**: Dropped the derivative `congestion_level` column to prevent data leakage during speed training.
* **SQL Query Bug Fixes**: Fixed a query bug with case-sensitive congestion matching (`'low'` vs `'Low'`).
* **Multi-Model Suite**: Evaluates and compares **Linear Regression, Ridge, Decision Tree, Random Forest, Gradient Boosting, and XGBoost**.
* **Parquet ETL Partitioning**: Aggregated traffic metrics are saved as a Parquet store partitioned by `location`.

---

## Project Structure

```
jakarta-traffic-analysis/
├── data/
│   ├── road_network.csv
│   ├── road_network_international.csv
│   ├── traffic_events.csv
│   └── weather_conditions.csv
│   └── traffic_sensor_data.csv (Git-ignored due to size; see instructions below)
├── notebooks/
│   └── case_study_optimized.ipynb
├── docs/
│   ├── Case Study5.pdf
│   └── project_architecture.png
├── .gitignore
└── README.md
```

---

## Installation & Prerequisites

### 1. Prerequisites
Ensure you have **Python 3.8+** and a Java Development Kit (JDK 8 or 11) installed on your system to run Spark.

### 2. Dependency Setup
Install all required libraries using `pip`:

```bash
pip install -q pyspark xgboost pandas scikit-learn matplotlib seaborn
```

### 3. Placing the Large Dataset
The main sensor dataset, `traffic_sensor_data.csv` (~21.3 MB), is excluded from Git to prevent repository bloat. 
* Download/copy `traffic_sensor_data.csv` and place it in the `data/` folder.
* Ensure all other CSV files are also located under `data/`.

---

## Execution Procedure

1. Launch Jupyter Notebook or JupyterLab:
   ```bash
   jupyter notebook
   ```
2. Navigate to the `notebooks/` directory.
3. Open and run all cells in [case_study_optimized.ipynb](notebooks/case_study_optimized.ipynb).
4. View Spark DataFrame output metrics, SQL EDA plots, and Scikit-Learn training comparison metrics directly inline.

---

## Machine Learning Model Evaluation

The models are trained to predict `average_speed_kmh` based on weather conditions (visibility, precipitation), vehicle distributions (cars, motorcycles, trucks, buses), hour of day, and holiday status. 

### Regression Model Comparison

| Model | MAE (km/h) | RMSE (km/h) | $R^2$ Score | MAPE (%) | Train Time (s) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Gradient Boosting** | **7.018** | **10.296** | **0.791** | **18.55%** | ~54.56s |
| **Random Forest** | 7.015 | 10.367 | 0.788 | 18.57% | ~87.19s |
| **XGBoost** | 7.034 | 10.369 | 0.788 | 18.60% | ~2.22s |
| **Decision Tree** | 7.131 | 10.636 | 0.777 | 18.85% | ~0.91s |
| **Linear Regression** | 9.284 | 11.977 | 0.717 | 23.14% | ~0.40s |
| **Ridge Regression** | 9.284 | 11.977 | 0.717 | 23.14% | ~0.30s |

> [!NOTE]
> **Gradient Boosting** achieved the best predictive performance (lowest RMSE and highest $R^2$ score), while **XGBoost** provided the best balance of speed and performance (training in just 2.22 seconds with almost identical accuracy to Gradient Boosting/Random Forest).

---

## Version Control and Pushing to GitHub

To push this local repository to your remote GitHub repository, run the following commands in your shell:

```bash
# 1. Add remote repository link
git remote add origin <your-github-repo-url>

# 2. Rename default branch to main
git branch -M main

# 3. Push code to main branch
git push -u origin main
```
