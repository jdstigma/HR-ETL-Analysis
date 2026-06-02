-- ============================================================
-- query_employees_salaries.sql
-- Active employees with their current salary
-- Output: Query Results/query_employees_salaries.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    s.salary,
    s.from_date AS salary_from
FROM employees e
JOIN salaries s
    ON  e.emp_no   = s.emp_no
    AND s.to_date  = '9999-01-01'
ORDER BY s.salary DESC;
