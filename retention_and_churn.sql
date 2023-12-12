use youtube_sql;

create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);

insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;


-- Cutsomer retention
select month(tm.order_date) as month_, count(distinct lm.cust_id) from transactions tm
left join transactions lm
on lm.cust_id = tm.cust_id and (month(tm.order_date) - month(lm.order_date) = 1)
group by month(tm.order_date);


-- Cutsomer Churn

select month(lm.order_date) as month_, count(distinct lm.cust_id) as churn from transactions lm
left join transactions tm
on lm.cust_id = tm.cust_id and (month(tm.order_date) - month(lm.order_date) = 1)
where tm.cust_id is null
group by month(lm.order_date)




