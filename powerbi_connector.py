# =============================================================
# powerbi_connector.py
# HR-ETL-Analysis — Power BI Python Data Connector
#
# HOW TO USE IN POWER BI:
#   1. Open Power BI Desktop
#   2. Get Data → Python script
#   3. Paste this entire script into the editor
#   4. Click OK — each DataFrame will appear as a separate table
#
# DATA SOURCE: GitHub raw URLs (always pulls latest from main)
# Requires: pandas, requests  (pip install pandas requests)
# =============================================================

import pandas as pd
import requests
from io import StringIO

REPO    = "jdstigma/HR-ETL-Analysis"
BRANCH  = "main"
BASE    = f"https://raw.githubusercontent.com/{REPO}/{BRANCH}"

def load_csv(folder, filename):
    """Fetch a CSV from the GitHub repo and return a DataFrame."""
    url = f"{BASE}/{folder}/{filename}"
    r = requests.get(url)
    r.raise_for_status()
    return pd.read_csv(StringIO(r.text))

# ── Query Results ─────────────────────────────────────────────
query_employees_departments = load_csv("Query Results", "query_employees_departments.csv")
query_employees_salaries    = load_csv("Query Results", "query_employees_salaries.csv")
query_employees_titles      = load_csv("Query Results", "query_employees_titles.csv")
query_manager_analysis      = load_csv("Query Results", "query_manager_analysis.csv")
query_promotion_history     = load_csv("Query Results", "query_promotion_history.csv")
query_salary_history        = load_csv("Query Results", "query_salary_history.csv")

# ── Cleaned Data ──────────────────────────────────────────────
table_employee_full_profile = load_csv("Cleaned Data", "table_employee_full_profile.csv")
table_tenure_segments       = load_csv("Cleaned Data", "table_tenure_segments.csv")

# ── EDA Outputs ───────────────────────────────────────────────
eda_salary_by_department    = load_csv("outputs", "eda_salary_by_department.csv")
eda_salary_by_title         = load_csv("outputs", "eda_salary_by_title.csv")
eda_salary_by_gender        = load_csv("outputs", "eda_salary_by_gender.csv")
eda_salary_growth_summary   = load_csv("outputs", "eda_salary_growth_summary.csv")
eda_avg_years_per_title     = load_csv("outputs", "eda_avg_years_per_title.csv")
eda_manager_analysis        = load_csv("outputs", "eda_manager_analysis.csv")
eda_tenure_segments         = load_csv("outputs", "eda_tenure_segments.csv")

# ── Regression Results ────────────────────────────────────────
regression_coefficients     = load_csv("outputs", "regression_coefficients.csv")
regression_model_comparison = load_csv("outputs", "regression_model_comparison.csv")
regression_model_metrics    = load_csv("outputs", "regression_model_metrics.csv")

# ── Profile Summaries ─────────────────────────────────────────
profile_employees           = load_csv("outputs", "profile_employees.csv")
profile_departments         = load_csv("outputs", "profile_departments.csv")
profile_salaries            = load_csv("outputs", "profile_salaries.csv")
profile_titles              = load_csv("outputs", "profile_titles.csv")
profile_dept_emp            = load_csv("outputs", "profile_dept_emp.csv")
profile_dept_manager        = load_csv("outputs", "profile_dept_manager.csv")

print(f"Loaded {22} tables successfully.")
