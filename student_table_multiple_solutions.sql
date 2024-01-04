use youtube_sql;

CREATE TABLE students(
 studentid int NULL,
 studentname nvarchar(255) NULL,
 subject nvarchar(255) NULL,
 marks int NULL,
 testid int NULL,
 testdate date NULL
);

insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');

select * from students;


-- 1) List of students who scored above average marks in each subject

-- Non efficient solution, each time it computes average [correlated subquery]

select studentid, studentname, subject 
from students s1
where marks > (select avg(s2.marks) from students s2 where s1.subject = s2.subject);

-- efficient solution
with cte as(select subject,avg(marks) as avg_marks from students group by subject)

select * from students s
join cte c on s.subject = c.subject
where s.marks > c.avg_marks;


-- 2) Get the % of students who score 90 in any subject amongst total students

select * from students;
select count(distinct studentid)/(select count(distinct studentid) from students) * 100 as percentage
from students
where marks>90;

-- 3) second highest and second lowest marks for each subject

with cte as(select subject,marks,
	dense_rank() over(partition by subject order by marks desc) rank1_,
    dense_rank() over(partition by subject order by marks asc) rank2_
 from students)
 
 select subject,
	max(case when rank1_ = 2 then marks else null end) as second_highest,
    max(case when rank2_ = 2 then marks else null end) as second_lowest
from cte
group by subject;



-- 4)For each student and test, identify if their marks increased or decreased from previous test

with cte as(select studentid,studentname,subject, testid, marks,
	lag(marks,1) over(partition by studentid order by testid,subject) as prev_marks
from students
group by 1,2,3,4
order by 1,4,3)

select *, 
	case when prev_marks is null then null when prev_marks>marks then "decreased" else "increased" end as status
from cte 
