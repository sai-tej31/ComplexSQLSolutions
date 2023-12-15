use youtube_sql;


drop table billings;
create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','1990-01-01',25)
,('Sehwag' ,'1989-01-01', 15)
,('Dhoni' ,'1989-01-01', 20)
,('Sachin' ,'1991-02-05', 30)
;

drop table HoursWorked;
create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '1990-07-01' ,3)
,('Sachin', '1990-08-01', 5)
,('Sehwag','1990-07-01', 2)
,('Sachin','1991-07-01', 4);


select * from billings;
select * from HoursWorked;

with cte as (select 
	emp_name,
    bill_date,
    bill_rate,
    lead(date_sub(bill_date,interval 1 day),1,'9999-12-31') over(partition by emp_name order by bill_date) end_date
from billings)

select 
	c.emp_name , sum(c.bill_rate*h.bill_hrs) as total_charges
from cte c
join HoursWorked h on h.emp_name = c.emp_name and h.work_date between c.bill_date and c.end_date
group by c.emp_name;

