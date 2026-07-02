# Project Submission Requirements Checklist

This document maps all the required deliverables for the **Jakarta Smart Transportation and Traffic Analytics System** submission to their respective files and paths in this repository.

---

## Deliverables Mapping

| Required Deliverable | Description / Details | Path in Repository |
| :--- | :--- | :--- |
| **1. Source Code** | Optimized PySpark + Scikit-Learn Python notebook. | [case_study_optimized.ipynb](file:///c:/work/ai_compute/casestudy/notebooks/case_study_optimized.ipynb) |
| **2. GitHub Repository Link** | Link to the remote code repository. | [GitHub Repository](https://github.com/tusharadelkar/jakarta-traffic-analysis) |
| **3. Dockerfile** | Production Docker configuration for containerization. | [Dockerfile](file:///c:/work/ai_compute/casestudy/Dockerfile) |
| **4. Kubernetes YAML Files** | Deployment and Service manifests for orchestration. | [deployment.yaml](file:///c:/work/ai_compute/casestudy/k8s/deployment.yaml)<br>[service.yaml](file:///c:/work/ai_compute/casestudy/k8s/service.yaml) |
| **5. CI/CD Pipeline Config** | GitHub Actions workflow for linting and testing. | [ci-cd.yml](file:///c:/work/ai_compute/casestudy/.github/workflows/ci-cd.yml) |
| **6. Execution Screenshots** | PNG dumps of execution plots directly from the notebook. | Located in [docs/](file:///c:/work/ai_compute/casestudy/docs/) (from `chart1` to `chart10`) |
| **7. EDA & Spark SQL Outputs** | Charts representing peak traffic, weather impact, SQL results. | [chart1_peak_hours.png](file:///c:/work/ai_compute/casestudy/docs/chart1_peak_hours.png)<br>[chart2_traffic_density_location.png](file:///c:/work/ai_compute/casestudy/docs/chart2_traffic_density_location.png)<br>[chart3_congestion_hotspots.png](file:///c:/work/ai_compute/casestudy/docs/chart3_congestion_hotspots.png)<br>[chart4_daily_trends.png](file:///c:/work/ai_compute/casestudy/docs/chart4_daily_trends.png)<br>[chart5_weather_impact.png](file:///c:/work/ai_compute/casestudy/docs/chart5_weather_impact.png)<br>[chart6_traffic_incidents.png](file:///c:/work/ai_compute/casestudy/docs/chart6_traffic_incidents.png)<br>[chart7_correlation_heatmap.png](file:///c:/work/ai_compute/casestudy/docs/chart7_correlation_heatmap.png) |
| **8. Model Evaluation Report** | Summary of model comparison, metrics, and importances. | [model_evaluation_report.md](file:///c:/work/ai_compute/casestudy/docs/model_evaluation_report.md) |
| **9. Final Project Documentation** | Main project guide and original case study brief. | [README.md](file:///c:/work/ai_compute/casestudy/README.md)<br>[Case Study5.pdf](file:///c:/work/ai_compute/casestudy/docs/Case%20Study5.pdf) |

---

## Brief Submission Instructions
1. Upload this restructured directory to your GitHub account using the commands specified in the [README.md](file:///c:/work/ai_compute/casestudy/README.md).
2. The large dataset `data/traffic_sensor_data.csv` is excluded from the repository. Reviewers can copy it directly into `data/` before running.
3. To run locally in Docker:
   ```bash
   docker build -t jakarta-traffic-analysis .
   docker run -p 8888:8888 -v $(pwd)/data:/app/data jakarta-traffic-analysis
   ```
4. To run on Kubernetes:
   ```bash
   kubectl apply -f k8s/
   ```
