use youtube_sql;
create table players_location
(
name varchar(20),
city varchar(20)
);
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location;

select 
	max(case when city = 'Mumbai' then name end) as mumbai,
    max(case when city = 'Delhi' then name end) as delhi,
    max(case when city = 'Bangalore' then name end) as bangalore
from
( select *, 
	row_number() over(partition by city order by name) as rn 
from players_location
) A
group by rn
order by rn;