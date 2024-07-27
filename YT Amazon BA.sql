WITH cte AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY employee, status ORDER BY dates) AS dt
    FROM emp_attendance
),
cte2 AS (
    SELECT *, DATEADD(day, -dt, dates) AS condt
    FROM cte
),
cte3 AS (
    SELECT employee, dates, status, condt
    FROM (
        SELECT *, COUNT(condt) OVER (PARTITION BY employee) AS summ
        FROM cte2
    ) AS sq
    WHERE summ > 1
)
SELECT employee,  MIN(dates) AS min_date, MAX(dates) AS max_date,status
FROM cte3
GROUP BY employee, condt,status
order by employee,min_date
