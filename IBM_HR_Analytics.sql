--Imported CSV files 
--Row Count Validation--
SELECT COUNT(*) FROM dim_employee;
SELECT COUNT(*) FROM dim_job;
SELECT COUNT(*) FROM dim_date;
SELECT COUNT(*) FROM fact_workforce;

--Employees linked correctly--
SELECT COUNT(*) AS orphan_employees
FROM fact_workforce f
LEFT JOIN dim_employee e
  ON f.employeenumber = e.employee_number
WHERE e.employee_number IS NULL;

--Jobs linked correctly--
SELECT COUNT(*) AS orphan_jobs
FROM fact_workforce f
LEFT JOIN dim_job j
  ON f.job_id = j.job_id
WHERE j.job_id IS NULL;

--Dates linked correctly--
SELECT COUNT(*) AS orphan_dates
FROM fact_workforce f
LEFT JOIN dim_date d
  ON f.date_id = d.date_id
WHERE d.date_id IS NULL;

--Overall Attrition Rate
SELECT ROUND(
  (SUM(CASE WHEN attrition_flag = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS attrition_rate_pct
FROM fact_workforce;

--Attrition by Department
SELECT
  j.department,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN f.attrition_flag = 1 THEN 1 ELSE 0 END) AS attritions,
  ROUND((SUM(CASE WHEN f.attrition_flag = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS attrition_rate_pct
FROM fact_workforce f
JOIN dim_job j ON f.job_id = j.job_id
GROUP BY j.department
ORDER BY attrition_rate_pct DESC;

--Attrition by Job Role
SELECT
  j.jobrole,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN f.attrition_flag = 1 THEN 1 ELSE 0 END) AS attritions
FROM fact_workforce f
JOIN dim_job j ON f.job_id = j.job_id
GROUP BY j.jobrole
ORDER BY attritions DESC;

--Attrition by Job Level
SELECT
  j.joblevel,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN f.attrition_flag = 1 THEN 1 ELSE 0 END) AS attritions
FROM fact_workforce f
JOIN dim_job j ON f.job_id = j.job_id
GROUP BY j.joblevel
ORDER BY j.joblevel;

--Attrition vs Overtime
SELECT
  overtime_flag,
  COUNT(*) AS employees,
  SUM(CASE WHEN attrition_flag = 1 THEN 1 ELSE 0 END) AS attritions
FROM fact_workforce
GROUP BY overtime_flag;

--Attrition vs Performance Rating
SELECT
  performance_rating,
  COUNT(*) AS employees,
  SUM(CASE WHEN attrition_flag = 1 THEN 1 ELSE 0 END) AS attritions
FROM fact_workforce
GROUP BY performance_rating
ORDER BY performance_rating;


CREATE OR REPLACE VIEW vw_hr_workforce_analytics AS
SELECT
  e.employee_number,
  e.age,
  e.gender,
  e.marital_status,
  e.education,
  e.education_field,
  j.jobrole,
  j.department,
  j.joblevel,
  j.businesstravel,
  f.monthly_income,
  f.overtime_flag,
  f.performance_rating,
  f.job_satisfaction,
  f.environment_satisfaction,
  f.attrition_flag,
  d.year,
  d.month,
  d.quarter
FROM fact_workforce f
JOIN dim_employee e ON f.employeenumber = e.employee_number
JOIN dim_job j ON f.job_id = j.job_id
JOIN dim_date d ON f.date_id = d.date_id;

SELECT COUNT(*) FROM vw_hr_workforce_analytics;

SELECT *
FROM vw_hr_workforce_analytics
WHERE ROWNUM <= 10;


