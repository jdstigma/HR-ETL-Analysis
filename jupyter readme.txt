hr_analysis.ipynb is ready. Here's what it does section by section:

Section	What it does
0. Setup	Imports, sets DATA_DIR and DB_PATH — works as-is in Codespaces
1. Load CSVs → SQLite	Reads all 6 CSVs, writes to hr.db, prints row counts
2. Data Profiling	Per-table: dtypes, null %, cardinality, date ranges, salary histogram, gender split, title counts
3. Analysis Table	SQL CTE pulls one row per active employee (filters to_date = '9999-01-01'), adds tenure_years and age_at_hire features
4. EDA	Salary by department, salary by title, salary vs. tenure scatter by gender
5. Regression	OLS via statsmodels: salary ~ tenure + age_at_hire + gender + C(dept) + C(title), residual plots, R²
6. Save back	Writes analysis_flat table to hr.db for your SQL queries
To run in Codespaces: just make sure the notebook and CSVs are in the same directory — the DATA_DIR = Path('.') line handles that. If statsmodels isn't pre-installed, uncommenting the pip install cell at the top takes care of it.