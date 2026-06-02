-- ============================================================
-- query_dept_salary_2001_vs_2002.sql
-- Average salary per department for 2001 and 2002
-- with year-over-year difference and % change
-- Output: Query Results/query_dept_salary_2001_vs_2002.csv
-- ============================================================

WITH salary_2001 AS (
    SELECT
        d.dept_name,
        ROUND(AVG(s.salary), 2) AS avg_salary_2001
    FROM salaries s
    JOIN dept_emp de
        ON  de.emp_no    = s.emp_no
        AND de.to_date   = '9999-01-01'
    JOIN departments d
        ON  d.dept_no    = de.dept_no
    WHERE STRFTIME('%Y', s.from_date) = '2001'
    GROUP BY d.dept_name
),
salary_2002 AS (
    SELECT
        d.dept_name,
        ROUND(AVG(s.salary), 2) AS avg_salary_2002
    FROM salaries s
    JOIN dept_emp de
        ON  de.emp_no    = s.emp_no
        AND de.to_date   = '9999-01-01'
    JOIN departments d
        ON  d.dept_no    = de.dept_no
    WHERE STRFTIME('%Y', s.from_date) = '2002'
    GROUP BY d.dept_name
)
SELECT
    a.dept_name,
    a.avg_salary_2001,
    b.avg_salary_2002,
    ROUND(b.avg_salary_2002 - a.avg_salary_2001, 2)                            AS difference,
    ROUND((b.avg_salary_2002 - a.avg_salary_2001) / a.avg_salary_2001 * 100, 2) AS pct_change
FROM salary_2001 a
JOIN salary_2002 b ON a.dept_name = b.dept_name
ORDER BY pct_change DESC;
