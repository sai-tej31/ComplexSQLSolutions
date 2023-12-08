use youtube_sql;

create table users14
(
user_id integer,
name varchar(20),
join_date date
);
insert into users14
values (1, 'Jon', CAST('2020-02-14' AS date)), 
(2, 'Jane', CAST('2020-02-14' AS date)), 
(3, 'Jill', CAST('2020-02-15' AS date)), 
(4, 'Josh', CAST('2020-02-15' AS date)), 
(5, 'Jean', CAST('2020-02-16-' AS date)), 
(6, 'Justin', CAST('2020-02-17' AS date)),
(7, 'Jeremy', CAST('2020-02-18' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('2020-3-1' AS date)), 
(2, 'Music', CAST('2020-03-2' AS date)), 
(2, 'P', CAST('2020-3-12' AS date)),
(3, 'Music', CAST('2020-3-15' AS date)), 
(4, 'Music', CAST('2020-3-15' AS date)), 
(1, 'P', CAST('2020-3-16' AS date)), 
(3, 'P', CAST('2020-3-22' AS date));

select * from users14;
select * from events;

select count(distinct case when datediff(e.access_date, u.join_date)<=30 then u.user_id end)/ count(distinct u.user_id) as ratio
from users14 u
left join events e on u.user_id = e.user_id and e.type='P'
where u.user_id in (select user_id from events where type = 'Music')




