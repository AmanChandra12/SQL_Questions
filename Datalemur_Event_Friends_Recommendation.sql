 create table friendship_status
(user_a_id int,
user_b_id int,
status  varchar(20)
);

insert into friendship_status values (111, 333, 'not_friends');
insert into friendship_status values (222, 333, 'not_friends');
insert into friendship_status values (333, 222, 'not_friends');
insert into friendship_status values (222, 111, 'friends');
insert into friendship_status values (111, 222, 'friends');
insert into friendship_status values (333, 111, 'not_friends');

create table event_rsvp
(user_id int,
event_id int,
event_type varchar(20),
attendance_status varchar(20),
event_date date
);

insert into event_rsvp values (111, 567,'public','going' ,'2022-07-12');
insert into event_rsvp values (222, 789,'private','going' ,'2022-07-15');
insert into event_rsvp values (333, 789,'private','maybe' ,'2022-07-15');
insert into event_rsvp values (111, 234,'private','not_going' ,'2022-07-18');
insert into event_rsvp values (222, 234,'private','going' ,'2022-07-18');
insert into event_rsvp values (333, 234,'private','going' ,'2022-07-18');

WITH cte AS
(
select event_type,user_id,count(user_id) as us
from event_rsvp
where event_type = 'private'
group by event_type,user_id
having COUNT(*)>1
),cte2 as(
select c1.user_id as c1u,c2.user_id as c2u
from cte c1
join cte c2
on c1.user_id<>c2.user_id
)
select f.user_a_id,f.user_b_id
from cte2
join friendship_status f
on cte2.c1u = f.user_a_id and cte2.c2u = f.user_b_id
where f.status = 'not_friends'
