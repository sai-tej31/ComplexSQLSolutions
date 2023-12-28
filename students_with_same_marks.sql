use youtube_sql;
create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

select * from exams;
-- 1	Chemistry	91
-- 1	Physics	91
-- 2	Chemistry	80
-- 2	Physics	90
-- 3	Chemistry	80
-- 4	Chemistry	71
-- 4	Physics	54

-- find students with same marks in Physics and Chemistry

with cte as(select student_id, 
	max(case when subject = 'Physics' then marks end) as physics_marks,
    max(case when subject = 'Chemistry' then marks end) as chemistry_marks
from exams
group by student_id)

select * from cte
where physics_marks = chemistry_marks;

-- Using Join method

select e1.*,e2.subject from exams e1
join exams e2 on e1.subject = 'Physics' and e2.subject = 'Chemistry' and e1.student_id = e2.student_id and e1.marks= e2.marks;

-- Method 3

select student_id from exams
where subject in ('Chemistry' , 'Physics') 
group by student_id
having count(distinct subject) = 2 and count(distinct marks) = 1










