use youtube_sql;

create table person(
person_id integer,
name varchar(20),
email varchar(30),
score integer
);

create table friend (
person_id integer,
friend_id integer
);

select * from person;
select * from friend;

insert into person values(1,'Alice','alice2018@hotmail.com',88),(2,'Bob','bob2018@hotmail.com',11),(3,'Davis','davis2018@hotmail.com',27),(4,'Tara','tara2018@hotmail.com',45),(5,'John','john2018@hotmail.com',63);
insert into friend values(1,2),(1,3),(2,1),(2,3),(3,5),(4,2),(4,3),(4,5);


with name_friend as (select 
	p.person_id as pid , p.name as pname , f.friend_id as fid
from person p 
join friend f on f.person_id = p.person_id)


select 
	 n.pid,n.pname,count(n.fid) as no_of_friends,sum(p.score) as total_friend_score
from name_friend n
join person p on n.fid = p.person_id
group by n.pid,n.pname
having sum(p.score)>100
order by n.pid