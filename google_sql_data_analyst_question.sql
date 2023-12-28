use youtube_sql;

create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');


select * from company_users;


-- find companies with atleast 2 users who speak both german and english

with cte as(select company_id, user_id, 
	max(case when language = 'English' then 1 else 0 end) as english,
    max(case when language = 'German' then 1 else 0 end) as german
from company_users
group by company_id, user_id)


select company_id, count(company_id) as user_count
from cte 
where english = 1 and german = 1
group by company_id
having count(company_id) >=2