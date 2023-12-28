use youtube_sql;

create table products1
(
product_id varchar(20) ,
cost int
);
insert into products1 values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

select * from products1;
select * from customer_budget;

-- find number of products along with the list that are within customer budget, chose the one with lesser cost in case of ties.
with cte as(select product_id,cost,
	sum(cost) over(order by cost rows between unbounded preceding and current row) as running_total
from products1)

select c.customer_id, c.budget,
--  p.product_id, p.product_id
 group_concat(p.product_id separator ',') as list_products, count(p.product_id) as num_of_products
from customer_budget c left join cte p
on  p.running_total <= c.budget
group by c.customer_id, c.budget;

