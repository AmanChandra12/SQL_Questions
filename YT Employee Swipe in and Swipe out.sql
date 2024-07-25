with cte as(
select employee_id,only_date,    datediff(HOUR , MIN(activity_time),MAX(activity_time) ) AS hours_diff
from (
select *,cast(activity_time as date) as only_date from swipe
) as sq
group by employee_id,only_date
),cte2 as(
select employee_id,only_date, sum(datediff(HOUR , activity_time,leead)) AS hours_diff2
from(
select *,cast(activity_time as date) as only_date 
,lead(activity_time)over(partition by employee_id order by employee_id,activity_time) as leead
from swipe
) as sq
where activity_type = 'login'
group by employee_id,only_date
)
select cte.employee_id as emp_id,cte.only_date as activity_day, hours_diff as total_hour,hours_diff2 as inside_hour from cte
join cte2 on
cte.employee_id=cte2.employee_id and cte.only_date=cte2.only_date
order by activity_day,emp_id
