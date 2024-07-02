use ytvideos
CREATE TABLE attendance (
    id INT,
    date DATE,
    present INT
);

INSERT INTO attendance (id, date, present) VALUES
(1, '2024-03-12', 1),
(1, '2024-03-13', 1),
(1, '2024-03-14', 1),
(1, '2024-03-15', 0),
(2, '2024-03-11', 1),
(2, '2024-03-12', 0),
(2, '2024-03-13', 1),
(2, '2024-03-14', 1),
(2, '2024-03-15', 1),
(3, '2024-03-14', 1),
(3, '2024-03-15', 1);


with cte as(
select *,DENSE_RANK() over (partition by id order by id) as rnk
from attendance
),cte2 as(
select *,ROW_NUMBER() over (partition by id order by date) as rw 
from cte
where rnk=1 and present = 1
),
cte3 as(
select *,DATEADD(day,-rw,date) as new_date
from cte2
),cte4 as(
select *,count(new_date) over (partition by id,new_date) as cnt
from cte3
),cte5 as(
select *,rank() over (order by cnt desc) as rnk2
from cte4
)
select distinct id
from cte5
where rnk2 = 1
