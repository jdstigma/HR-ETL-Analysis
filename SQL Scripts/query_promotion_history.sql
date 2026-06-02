-- ============================================================
-- query_promotion_history.sql
-- Title history per employee with duration at each title
-- Output: Query Results/query_promotion_history.csv
-- ============================================================

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    t.title,
    t.from_date,
    t.to_date,
    CASE
        WHEN t.to_date = '9999-01-01'
        THEN ROUND((JULIANDAY('2002-08-01') - JULIANDAY(t.from_date)) / 365.25, 2)
        ELSE ROUND((JULIANDAY(t.to_date)   - JULIANDAY(t.from_date)) / 365.25, 2)
    END AS years_in_title,
    ROW_NUMBER() OVER (PARTITION BY t.emp_no ORDER BY t.from_date) AS title_sequence
FROM titles t
JOIN employees e ON e.emp_no = t.emp_no
ORDER BY t.emp_no, t.from_date;
