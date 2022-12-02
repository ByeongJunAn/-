use marketdb;

update city_popul
set city_name = '서울'
where city_name='Seoul';

select * from city_popul where city_name='서울';

update city_popul
set city_name= '뉴욕', population=0
where city_name= 'New York';

select * from city_popul where city_name='뉴욕';    

update city_popul set population = population / 10000;


delete from city_popul where city_name='뉴욕';
delete from city_popul where city_name like 'new%';

delete from city_popul where city_name like 'new%' limit 5;
delete from city_popul where city_name = 'breda' limit 5;
delete from city_popul where population= 15 limit 3;