use youtube_sql;

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders;

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


-- Solution --
-- create a common table expression wirh rank which gives frequecny of customer

with cte as (select 
	customer_id,order_date,
    rank() over(partition by customer_id order by order_date) as frequency
from customer_orders)

select 
	order_date,
    sum(frequency=1) as new_customers,
    sum(frequency>1) as repeated_customers
from cte
group by order_date
order by order_date;
    
    
    
    
    
    
    
    