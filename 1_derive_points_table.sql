create table youtube_sql.icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO youtube_sql.icc_world_cup values('India','SL','India');
INSERT INTO youtube_sql.icc_world_cup values('SL','Aus','Aus');
INSERT INTO youtube_sql.icc_world_cup values('SA','Eng','Eng');
INSERT INTO youtube_sql.icc_world_cup values('Eng','NZ','NZ');
INSERT INTO youtube_sql.icc_world_cup values('Aus','India','India');

WITH cte as(
	select Team_1 as team, 
		case 
		when Team_1=Winner then 1 else 0 end as wins
	from youtube_sql.icc_world_cup 
	union all
	select Team_2 as team,case 
		when Team_2=Winner then 1 else 0 end as wins
	from youtube_sql.icc_world_cup)


select 
	team as Team_Name, 
	COUNT(team) as Matches_Played,
    sum(Wins=1) as no_of_wins,
    sum(Wins=0) as no_of_loss,
    2 * sum(Wins=1) as total_points 
from  cte
group by team
order by total_points desc;    



