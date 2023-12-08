use youtube_sql;

create table sales_11 (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales_11 values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);


with recursive cte as(
select product_id,min(period_start) as start_date, max(period_end) as end_date, average_daily_sales as values_
from sales_11
group by 1,4
union all
select product_id, date_add(start_date, interval 1 day) as start_date, end_date as end_date, values_
from cte
where datediff(end_date,start_date) >0
)

select product_id, year(start_date) as report_year, count(values_)* values_ as total_amount from cte
group by 1,2
order by 1,2


