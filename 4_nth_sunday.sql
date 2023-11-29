set @today_date = '2023-11-05';
set @n = 2;

select if(6-weekday(@today_date)>0, date_add(@today_date, interval 6-weekday(@today_date) + (@n-1)*7  day), date_add(@today_date, interval (@n)*7 day)) as nth_sunday

