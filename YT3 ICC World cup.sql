create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

with cte as(
select Team_1 as t1 , Team_2 as t2,Winner
from icc_world_cup
union all
select Team_2 as t1 , Team_1 as t2,Winner
from icc_world_cup
)
select t1,count(*) as matches_played,
sum(case when t1=Winner then 1 else 0 end) as no_of_winners,
sum(case when t2=Winner then 1 else 0 end) as no_of_losers
from cte
group by t1
