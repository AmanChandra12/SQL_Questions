use ytvideos


create table cinema_tickets(seat_number varchar(100) not null, occupancy int);
insert into cinema_tickets(seat_number, occupancy) values('A1',1),('A2',1),('A3',0),('A4',0),('A5',0),('A6',0),
('A7',1),('A8',1),('A9',0),('A10',0),('B1',0),('B2',0),('B3',0),('B4',1),('B5',1),('B6',1),
('B7',1),('B8',0),('B9',0),('B10',0),('C1',0),('C2',1),('C3',0),('C4',1),('C5',1),('C6',0),
('C7',1),('C8',0),('C9',0),('C10',1);


with cte as(
SELECT *,cast(SUBSTRING(seat_number, 2, LEN(seat_number) - 1) as int) as sn,
SUBSTRING(seat_number,1,1) as seat
FROM cinema_tickets
),cte2 as(
select *,
lead(occupancy,1) over (partition by seat order by sn) as l1,
lead(occupancy,2) over (partition by seat order by sn) as l2,
lead(occupancy,3) over (partition by seat order by sn) as l3
from cte
)
select seat_number,CONCAT(seat,sn+3) as succestive_next_seat
from cte2
where occupancy+l1+l2+l3 = 0 