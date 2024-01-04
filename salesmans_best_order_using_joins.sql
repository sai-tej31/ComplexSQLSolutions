use youtube_sql;
CREATE TABLE int_orders(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount float NOT NULL
);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

INSERT into int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

INSERT into int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

INSERT into int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

INSERT into int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);


select * from int_orders;


-- largest order by value for each sales person 
-- DO not use cte, temp table, sub query, window function

select o1.* from int_orders o1 
left join int_orders o2 on o1.salesperson_id = o2.salesperson_id
group by o1.order_number, o1.order_date,o1.cust_id,o1.salesperson_id,o1.amount
having o1.amount = max(o2.amount)
