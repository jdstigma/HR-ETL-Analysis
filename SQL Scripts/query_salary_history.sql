-- ============================================================
-- query_salary_history.sql
-- Full salary history per employee with growth metrics
-- Output: Query Results/query_salary_history.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    d.dept_name,
    t.title,
    s.salary,
    s.from_date,
    s.to_date,
    LAG(s.salary) OVER (PARTITION BY s.emp_no ORDER BY s.from_date) AS prev_salary,
    ROUND(
        (s.salary - LAG(s.salary) OVER (PARTITION BY s.emp_no ORDER BY s.from_date)) * 100.0
        / LAG(s.salary) OVER (PARTITION BY s.emp_no ORDER BY s.from_date), 2
    ) AS pct_change
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no
LEFT JOIN dept_emp de
    ON  de.emp_no  = s.emp_no
    AND de.to_date = '9999-01-01'
LEFT JOIN departments d ON d.dept_no = de.dept_no
LEFT JOIN titles t
    ON  t.emp_no  = s.emp_no
    AND t.to_date = '9999-01-01'
ORDER BY s.emp_no, s.from_date;
