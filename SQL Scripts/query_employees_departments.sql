-- ============================================================
-- query_employees_departments.sql
-- Active employees with their current department
-- Output: Query Results/query_employees_departments.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    d.dept_no,
    d.dept_name
FROM employees e
JOIN dept_emp de
    ON  e.emp_no   = de.emp_no
    AND de.to_date = '9999-01-01'
JOIN departments d
    ON  de.dept_no = d.dept_no
ORDER BY d.dept_name, e.last_name;
