use youtube_sql;


create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

with cte as(select *,
row_number() over(partition by username order by startDate) as rank_,
count(username) over(partition by username ) as total_count
from UserActivity)

select * from cte
where rank_ = 2 or total_count = 1