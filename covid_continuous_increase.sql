use youtube_sql;

create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);


select * from covid;


-- selcect cities that have continuos increase in covid cases


with cte as(
select *,
	rank() over(partition by city order by cases) rank_,
    lag(days,1) over(partition by city order by cases) prev_rank_day
from covid)

select  city,
	sum(case when prev_rank_day > days then 1 else 0 end) as cond
 from cte
group by city
having cond =0 and count(distinct rank_) = count(rank_);



