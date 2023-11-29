use youtube_sql;
create table sales(
	year int,
	month int,
    sales int);

insert into sales
	values(2012,1,300),(2012,1,500),(2012,1,800),(2012,2,8000),(2012,2,300),(2012,3,500),
    (2013,6,300),(2013,1,500),(2013,1,800),(2013,2,8000),(2013,2,300),(2013,3,500),
    (2014,1,300),(2014,1,500),(2014,1,800),(2014,2,8000),(2014,2,300),(2014,3,500),
    (2015,1,300),(2015,1,500),(2015,1,800),(2015,2,8000),(2015,2,300),(2015,3,500);
    
select
	year,
    month,
    sales,
    sum(sales) over(order by year, month rows between 2 preceding and 0 preceding) as rolling_window_3,
    sum(sales) over(order by year, month rows between unbounded preceding and 0 preceding) as running_sales    
from sales
group by year,month

