# HR-ETL-Analysis

End-to-end HR data pipeline built on the classic MySQL employees dataset. Raw CSVs
are loaded into a SQLite database, profiled and analyzed in Python, exported as
structured tables, and surfaced in an interactive **Power BI** report.

---

## 📊 Power BI Report

**[⬇ Download the report — `Employee-Profiling-Year-to-Year.pbix`](https://github.com/jdstigma/HR-ETL-Analysis/releases/latest)**
&nbsp;·&nbsp; [All releases](https://github.com/jdstigma/HR-ETL-Analysis/releases)

`Employee Profiling: Year to Year` visualizes employee demographics, salary, tenure,
promotions, and department makeup across the dataset's timeline. Grab it from the
[latest release](https://github.com/jdstigma/HR-ETL-Analysis/releases/latest) and
open it in **Power BI Desktop** — the data model is embedded, so it opens and
renders with no connection or refresh required.

> The `.pbix` is distributed via **Releases** (not the repo tree) because it's a
> ~57 MB binary. To reproduce or extend it against live data, use the Python
> connector described in [Power BI Integration](#power-bi-integration) below.

---

## Repository Structure

```
HR-ETL-Analysis/
├── dataset/                        # Raw CSVs + Jupyter notebook
│   ├── employees.csv
│   ├── departments.csv
│   ├── dept_emp.csv
│   ├── dept_manager.csv
│   ├── salaries.csv
│   ├── titles.csv
│   ├── hr_analysis.ipynb           # Main analysis notebook
│   └── hr_analysis_executed.ipynb  # Auto-executed output (CI)
│
├── SQL Scripts/                    # SQLite join scripts
│   ├── query_employees_departments.sql
│   ├── query_employees_salaries.sql
│   ├── query_employees_titles.sql
│   ├── query_salary_history.sql
│   ├── query_promotion_history.sql
│   ├── query_manager_analysis.sql
│   ├── table_employee_full_profile.sql
│   └── table_tenure_segments.sql
│
├── Query Results/                  # CSVs from query_*.sql scripts
├── Cleaned Data/                   # CSVs from table_*.sql scripts
├── outputs/                        # Charts, EDA, and regression files
├── Simple Profile/                 # SQLite dot command outputs
└── powerbi_connector.py            # Power BI Python data connector
```

The Power BI report itself lives in [Releases](https://github.com/jdstigma/HR-ETL-Analysis/releases), not in the tree.

---

## Dataset

Six tables from the [MySQL employees sample database](https://github.com/datacharmer/test_db):

| Table | Rows | Description |
|---|---|---|
| `employees` | 300,024 | Employee demographics and hire dates |
| `departments` | 9 | Department names and IDs |
| `dept_emp` | 157,368 | Employee → department assignments (with history) |
| `dept_manager` | 24 | Department manager assignments |
| `salaries` | 78,468 | Salary history per employee |
| `titles` | 49,432 | Title history per employee |

---

## Pipeline

```
Raw CSVs → SQLite (hr.db) → Profiling → EDA → Regression → SQL Joins → Power BI
```

The GitHub Action (`run_notebook.yml`) runs automatically on every push to `main` and:
1. Executes `hr_analysis.ipynb` end to end
2. Profiles the SQLite database with dot commands
3. Runs all SQL scripts in `SQL Scripts/`
4. Commits all outputs back to the repo

---

## Analysis Summary

### Data Profiling
- Zero nulls across all tables (1 negligible null in `titles`)
- Date range: hires 1985–2000, salary records through 2002
- 6,652 active employees after joining on `to_date = '9999-01-01'`

### OLS Regression — Salary Drivers (log model, R² = 0.357)

| Predictor | Effect | Significant |
|---|---|---|
| Sales department | +28.3% vs Customer Service | ✅ |
| Marketing department | +17.5% | ✅ |
| Finance department | +14.3% | ✅ |
| Senior Engineer title | +16.4% vs Asst. Engineer | ✅ |
| Senior Staff title | +14.4% | ✅ |
| Tenure | +1.57% per year | ✅ |
| Gender (M vs F) | -0.2% | ❌ p=0.670 |

### Extended Analyses
- **Salary growth over time** — average salary trend by year
- **Promotion analysis** — average years spent in each title
- **Manager analysis** — current managers by department with salary and tenure in role
- **Tenure segments** — Early / Mid / Established / Veteran salary distributions

---

## Power BI Integration

There are two ways to work with this project in Power BI:

**1. Open the finished report** — download `Employee-Profiling-Year-to-Year.pbix`
from the [latest release](https://github.com/jdstigma/HR-ETL-Analysis/releases/latest)
and open it in Power BI Desktop. Data is embedded; nothing else required.

**2. Build from live data** — `powerbi_connector.py` at the repo root loads all 22
CSV tables directly from GitHub raw URLs into Power BI via the Python script connector:

1. Power BI Desktop → Get Data → Python script
2. Paste the contents of `powerbi_connector.py`
3. Select tables from the navigator

**Suggested relationships:**

| From | To | Key |
|---|---|---|
| `table_employee_full_profile` | `query_salary_history` | `emp_no` |
| `table_employee_full_profile` | `query_promotion_history` | `emp_no` |
| `table_employee_full_profile` | `query_manager_analysis` | `dept_name` |
| `table_tenure_segments` | `table_employee_full_profile` | `emp_no` |

---

## Requirements

```
pandas
numpy
matplotlib
seaborn
statsmodels
requests
```
