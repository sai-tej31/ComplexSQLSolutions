use youtube_sql;

create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from spending;

with cte as(
select spend_date, user_id, sum(amount) as total_amount,group_concat(platform) as platform
from spending
group by user_id,spend_date
)

select spend_date,
	case
		when platform = 'mobile,desktop' or platform = 'desktop,mobile' then 'both'
        else platform
	end as platform,
    total_amount,
    count(user_id) as total_users
from 
cte
group by spend_date,user_id 
order by spend_date