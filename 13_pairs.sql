use youtube_sql;


create table orders12
(
order_id int,
customer_id int,
product_id int
);

insert into orders12 VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');




select * from orders12;
select * from products;


with cte as (select o.*, p.name from orders12 o
join products p on o.product_id = p.id)

select concat(c1.name,' ' ,c2.name) as pair_name, count(concat(c1.name,' ' ,c2.name)) as purch_freq
from cte c1
cross join cte c2 on c1.order_id = c2.order_id and c1.product_id < c2.product_id
where c1.name != c2.name
group by 1








