use youtube_sql;

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity;

-- Active Users each day

select 
	event_date, count(distinct user_id) as users
from activity
group by event_date; 

-- Active Users each week

select 
	week(event_date) week_number, count(distinct user_id)  as users
from activity
group by week(event_date); 


-- datewise who made purcahse same day after installing
 
select event_date,count(distinct new_user) as user_count from(select 
	event_date, count(event_name)  as events_,
    case when count(event_name) >=2 then user_id else null end as new_user
from activity
group by user_id, event_date
) a
group by event_date;


-- percentage of paid users in the particular country


with cte as (select 
	user_id, event_name,
    event_date,
	Case when country = 'India' then country
		 when country = 'USA' then country
         else 'others' end as region
from activity)
select * from cte;

select region, count( case when event_name = 'app-purchase' then user_id else null end)/count(case when event_name = 'app-installed' then user_id else null end) as perc_ from cte
group by region;



-- percentage of paid users in total by country


with cte as (select 
	user_id, event_name,
    event_date,
	Case when country = 'India' then country
		 when country = 'USA' then country
         else 'others' end as region
from activity)


select region,(100) * count( case when event_name = 'app-purchase' then user_id else null end)/(select count(case when event_name = 'app-purchase' then user_id else null end) from cte) as perc_country from cte
group by region;

-- datewise who made purcahse next day after installing
 
 
 
with cte2 as (select *,
	lag(event_name,1) over(partition by user_id order by event_date) as prev_ev_name,
	lag(event_date,1) over(partition by user_id order by event_date) as prev_ev_date
from activity)

select event_date, count(case when prev_ev_name = "app-installed" and event_name = 'app-purchase' and datediff(event_date,prev_ev_date)=1 then user_id else null end) as user_count
from cte2
group by event_date
