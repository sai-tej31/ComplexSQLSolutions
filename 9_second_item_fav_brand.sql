use youtube_sql;

create table users9 (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));
 create table orders9 (
 order_id       int ,
 order_date     date,
 item_id        int,
 buyer_id       int,
 seller_id      int 
 );
 create table items9
 (
 item_id        int,
 item_brand     varchar(50)
 );


 insert into users9 values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');
 insert into items9 values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');
 insert into orders9 values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
 
 with seller_brand as (
	 select 
		o.*, 
		i.item_brand,
		row_number() over(partition by seller_id order by order_date) as item_num
	 from orders9 as o
	 join items9 as i on o.item_id=i.item_id
 )

 
select 
	u.user_id,
    case 
		when u.favorite_brand = s.item_brand then 'yes'
        else 'no'
	end as sec_item_fav_brand
from users9 u left join seller_brand s
on u.user_id = s.seller_id and s.item_num = 2;

