set @today_date = now(); -- returns current date and time

select @today_date;

select @today_date,date_add(@today_date, interval 3 day); -- adds 3 days 
select @today_date,date_add(@today_date, interval 30 second); -- adds 30 seconds 
select @today_date,date_add(@today_date, interval 30 minute); -- adds 30 minutes 
select @today_date,date_add(@today_date, interval 3 month); -- adds 3 months 
select @today_date,date_add(@today_date, interval 3 year); -- adds 3 years 


select @today_date,date_sub(@today_date, interval 3 day); -- subs 3 days 
select @today_date,date_sub(@today_date, interval 30 second); -- subs 30 seconds 
select @today_date,date_sub(@today_date, interval 30 minute); -- subs 30 minutes 
select @today_date,date_sub(@today_date, interval 3 month); -- subs 3 months 
select @today_date,date_sub(@today_date, interval 3 year); -- subs 3 years 

select datediff(@today_date, '2023-12-28'); -- number of days diff

select to_seconds(@today_date); -- convert to seconds

select to_seconds(@today_date) - to_seconds('2023-11-29 09:25:00'); -- diff in seconds

select second(@today_date); -- returns seconds
select minute(@today_date); -- returnsminutes 
select hour(@today_date); -- returns hour of the day
select day(@today_date); -- returns the day of month
select week(@today_date); -- returns week of year
select month(@today_date); -- returns month of year
select quarter(@today_date); -- returns the (1-4) quarter no of year 
select year(@today_date); -- returns year from the date

select date(@today_date); -- returns date
select time(@today_date); -- returns time
select dayofyear(@today_date); -- returns day number of year
select last_day(@today_date); -- returns last day of month
select unix_timestamp(@today_date);
