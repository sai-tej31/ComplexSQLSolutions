use youtube_sql;


create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR'),
('B','Bangalore','B3@gmail.com',2,'MONITOR'),('C','Bangalore','C2@gmail.com',1,'MONITOR'),('C','Bangalore','C2@gmail.com',1,'MONITOR'),
('C','Bangalore','C3@gmail.com',1,'MONITOR');

with cte as(
	select 
		name,
        count(floor) total_visits,
		group_concat(distinct(resources)) as resources_used
	from entries
	group by name)
select t.name, t.total_visits,t2.most_visited_floor,t.resources_used from cte t
join 
	(select
		name,
		count(floor) as most_visited_floor,
		rank() over(partition by name order by count(floor) desc) as rank1
	from entries
	group by name,floor) t2
on t.name = t2.name and t2.rank1=1
