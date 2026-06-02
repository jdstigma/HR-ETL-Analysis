-- ============================================================
-- query_employees_titles.sql
-- Active employees with their current title
-- Output: Query Results/query_employees_titles.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    t.title,
    t.from_date AS title_from
FROM employees e
JOIN titles t
    ON  e.emp_no  = t.emp_no
    AND t.to_date = '9999-01-01'
ORDER BY t.title, e.last_name;
