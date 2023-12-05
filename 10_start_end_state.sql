use youtube_sql;

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');



with cte as(select 
	date_value,
    state,
    dense_rank() over(partition by state order by date_value) as rank_within
from tasks
order by date_value)

select 
	min(date_value) as start_date,
    max(date_value) as end_date,
    state
from cte
group by date_sub(date_value,interval rank_within-1 day),state
