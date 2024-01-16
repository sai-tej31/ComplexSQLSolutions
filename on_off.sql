use youtube_sql;

create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');

select * from event_status; 

/*
Find count between each login and logout
*/
with cte as(
select event_time, sum(case when prev_ = 'off' then 1 else 0 end) over(order by event_time) as group_key
from 
	(select 
		event_time,
		status, 
		lag(status,1) over() as prev_
	from event_status) A)

select min(event_time) as start, max(event_time) as end, count(event_time)-1 as count
from cte
group by group_key



