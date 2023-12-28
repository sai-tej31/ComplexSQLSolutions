use youtube_sql;

CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

select Store, concat('Q',(10 - sum(right(quarter,1)))) as missed_quarter
from stores
group by Store;
 
 
with recursive cte as (
select distinct store, 1 as q_no from stores
union all
select store, q_no+1 as q_no from cte
where q_no<4)
select c.store, concat('Q' ,c.q_no) as missed_quarter from cte c 
left join stores s on c.q_no = right(s.Quarter,1) and s.store = c.store
where s.store is null
order by store
