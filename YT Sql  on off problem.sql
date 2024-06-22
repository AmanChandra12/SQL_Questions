create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');

with cte as(
select *,lag(status ,1,status) over( order by event_time ) as prev_status
from event_status
),cte2 as(
select *,sum(case when status = 'on' and prev_status = 'off'  then 1 else 0 end) over (order by event_time) as summ
from cte
)
select min(event_time) as min_time,max(event_time) as max_time,count(summ)-1 as cnt
from cte2
group by summ
