End-to-End HR Workforce Analytics ETL Project
## Project Overview

This project demonstrates an end-to-end HR workforce analytics solution, showcasing the full data lifecycle from raw data ingestion to analytics-ready insights. The solution mirrors enterprise HR analytics practices, enabling workforce planning and attrition analysis.

## Business Objective

- Analyze employee attrition patterns and identify high-risk departments and roles.
- Support data-driven workforce planning and retention strategies.
- Answer key questions: overall attrition rate, department/job-level attrition, and impact of overtime, performance, and satisfaction.

## Architecture & Data Flow
Raw HR Dataset (Kaggle)
        ↓
Python (ETL: Extract & Transform)
        ↓
Curated CSVs (Dimensions & Fact)
        ↓
Oracle SQL (Data Warehouse)
        ↓
Analytical SQL View
        ↓
Power BI Dashboard (Insights & KPIs)
Data Model (Star Schema)

## Dimension Tables:

1) DIM_EMPLOYEE: employee_number, age, gender, maritial_status, education, education_field
2)DIM_JOB: job_id, jobrole, department, joblevel, businesstravel
3) DIM_DATE: date_id, snapshot_date, year, month, quarter
4) Fact Table:
FACT_WORKFORCE: employeenumber, job_id, date_id, attrition_flag, monthly_income, overtime_flag, performance_rating, job_statisfication, environment_satisfation

The fact table links all dimensions for analytics.

## Analytics Layer

- Created SQL view IBM_hr_analytics joining dimensions with fact table.
- Serves as a semantic layer for Power BI, ensuring consistent business logic and simplified reporting.

## Key KPIs & Insights

- Total employees and attrition count/rate
- Attrition by department, job role, and job level
- Attrition vs overtime and performance rating
- Job satisfaction and environment satisfaction impact on attrition

## Tools & Technologies
- Python: Pandas, NumPy (ETL & transformations)
- Oracle SQL: Data warehouse, analytical views
- Power BI: Dashboard design and visualization
- Jupyter Notebook: Development environment

## Author - Pallavi Mali
