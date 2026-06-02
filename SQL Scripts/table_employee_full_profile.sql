-- ============================================================
-- table_employee_full_profile.sql
-- One row per active employee — all 6 tables joined
-- Includes: current dept, title, salary, tenure, age at hire
-- Output: Cleaned Data/table_employee_full_profile.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    e.birth_date,
    e.hire_date,
    d.dept_no,
    d.dept_name,
    t.title,
    s.salary,
    s.from_date                         AS salary_from,
    t.from_date                         AS title_from,
    de.from_date                        AS dept_from,
    ROUND(
        (JULIANDAY('2002-08-01') - JULIANDAY(e.hire_date)) / 365.25, 2
    )                                   AS tenure_years,
    ROUND(
        (JULIANDAY(e.hire_date) - JULIANDAY(e.birth_date)) / 365.25, 1
    )                                   AS age_at_hire
FROM employees e
JOIN dept_emp de
    ON  e.emp_no   = de.emp_no
    AND de.to_date = '9999-01-01'
JOIN departments d
    ON  de.dept_no = d.dept_no
JOIN titles t
    ON  e.emp_no   = t.emp_no
    AND t.to_date  = '9999-01-01'
JOIN salaries s
    ON  e.emp_no   = s.emp_no
    AND s.to_date  = '9999-01-01'
ORDER BY d.dept_name, e.last_name;
