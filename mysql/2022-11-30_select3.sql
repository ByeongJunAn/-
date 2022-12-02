create table  hongong1(toy_id int, toy_name char(4), age int);

insert into hongong1(toy_id, toy_name) values (2, '버즈');
select *from hongong1;

insert into hongong1(age, toy_name, toy_id) values(25, '제시', 3);
insert into hongong1 values (4, '우디', 20);
insert into hongong1 values (5, '시드', null); -- 값이 없으면 null이라도 넣어서 갯수를 맞춰줘야 한다. 


-- auto increment에서 number 조회
select last_insert_id();

alter table buy auto_increment=100;
insert into buy values(NULL, 'APN', '아이폰5', '디지털', 2900, 1);
select * from buy;
select last_insert_id();
set @@auto_increment_increment=1;

insert into hongong1 values(6, '버즈2', 24), (7, '우디2', 26);


select count(*) from world.city;

select * from world.city limit 5;

create table city_popul(city_name char(35), population int);


 insert into city_popul 
select name population from world.city;
select * from city_popul;


