-- ============================================================
-- table_tenure_segments.sql
-- Active employees bucketed into early/mid/late career bands
-- Output: Cleaned Data/table_tenure_segments.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    d.dept_name,
    t.title,
    s.salary,
    ROUND(
        (JULIANDAY('2002-08-01') - JULIANDAY(e.hire_date)) / 365.25, 2
    ) AS tenure_years,
    CASE
        WHEN (JULIANDAY('2002-08-01') - JULIANDAY(e.hire_date)) / 365.25 <  5 THEN 'Early (0-5 yrs)'
        WHEN (JULIANDAY('2002-08-01') - JULIANDAY(e.hire_date)) / 365.25 < 10 THEN 'Mid (5-10 yrs)'
        WHEN (JULIANDAY('2002-08-01') - JULIANDAY(e.hire_date)) / 365.25 < 15 THEN 'Established (10-15 yrs)'
        ELSE                                                                        'Veteran (15+ yrs)'
    END AS tenure_segment
FROM employees e
JOIN dept_emp de
    ON  e.emp_no   = de.emp_no
    AND de.to_date = '9999-01-01'
JOIN departments d ON d.dept_no = de.dept_no
JOIN titles t
    ON  t.emp_no  = e.emp_no
    AND t.to_date = '9999-01-01'
JOIN salaries s
    ON  s.emp_no  = e.emp_no
    AND s.to_date = '9999-01-01'
ORDER BY tenure_years DESC;
