-- ============================================================
-- query_manager_analysis.sql
-- Department managers with tenure in role and current salary
-- Output: Query Results/query_manager_analysis.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    d.dept_name,
    dm.from_date                                        AS manager_from,
    dm.to_date                                          AS manager_to,
    CASE
        WHEN dm.to_date = '9999-01-01'
        THEN ROUND((JULIANDAY('2002-08-01') - JULIANDAY(dm.from_date)) / 365.25, 2)
        ELSE ROUND((JULIANDAY(dm.to_date)   - JULIANDAY(dm.from_date)) / 365.25, 2)
    END                                                 AS years_as_manager,
    CASE WHEN dm.to_date = '9999-01-01' THEN 'Current' ELSE 'Former' END AS status,
    s.salary                                            AS current_salary
FROM dept_manager dm
JOIN employees   e  ON  e.emp_no   = dm.emp_no
JOIN departments d  ON  d.dept_no  = dm.dept_no
LEFT JOIN salaries s
    ON  s.emp_no  = dm.emp_no
    AND s.to_date = '9999-01-01'
ORDER BY d.dept_name, dm.from_date;
