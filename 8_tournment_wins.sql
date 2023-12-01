use youtube_sql;

create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

select * from players;
select * from matches;



with player_score as(select match_id, first_player as player, first_score as score
from matches
union all
select match_id, second_player as player, second_score as score
from matches)

select * from (
	select p.group_id, p.player_id, sum(score) as score, row_number() over(partition by p.group_id order by sum(score) desc, player_id asc) as rank_
	from player_score ps
	join players p
	on ps.player = p.player_id
    group by p.group_id, p.player_id )p
where rank_ = 1
