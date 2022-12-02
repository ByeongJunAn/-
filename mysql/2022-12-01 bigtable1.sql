SELECT * FROM marketdb.big_table1;

create table big_table2(select * from world.city, sakila.country);

create table big_table3(select * from world.city, sakila.country);

select count(*) from big_tabel1;

delete from big_table1; 

drop table big_table2;

truncate big_table3;

create table hongong4 (
tinyint_col tinyint,
smallint_col smallint,
int_col      int, 
bigint_col bigint);


insert into hongong4 values(
127,32767,2147483647,90000000000000000);

insert into hongong4 values(
128, 32768, 2147483648, 900000000000000001); 


desc member;

select cast('2022-12-01 10:19:20.123' as DATE) as date;
select cast('2022-12-01 10:19:20.113' as TIME) as 'Time';
select cast('2022-12-01 10:19:20.113' as DATETIME) as 'DateTime';

set @myvar1 = 5;
set @myvar2 = 3;
set @myvar3 = 4.25;
set @myvar4 = '가수 이름 ==> ';
select @myvar1;
select @myvar2 + @myvar3 as ' 3 + 4.25 ';
set @height = 160;
select @myvar4, mem_name from member where height > @height;

-- 변수에 값을 넣고 limit의 갯수로 활용하는 sql문 작성해 봅시다.
set @myvar5 =5;
select @var4, mem_name, height from member where height > @height limit 5; -- 여기서 리밋에 숫자만 가능

-- 해결법
set @lcnt =5;
prepare mySql from 'select mem_name, height from member limit?';
execute mySql using @lcnt;

set @lcnt =5;
prepare mySql from 'select ?, mem_name, height from marketdb.member where height  > ? limit?';
execute mySql using @myVar4, @height, @lcnt;

select avg(price) as '평균 가격'  from buy;
select cast(avg(price) as signed integer) '평균가격' from buy;
select convert(avg(price), signed integer) '평균 가격' from buy;

select cast('2022$12$01' as DATE);
select cast('2022/12/01' as DATE);
select cast('2022%12%01' as DATE);
select cast('2022@12@01' as DATE);

select num, concat(cast(price as char), 'x', cast(amount as char), '=')
'가격x수량', price*amount '구매액'
from buy ;


select if(300>200, '참이다', '거짓이다') 결과;
select ifnull(null, '널이군요'), ifnull(100, '널이군요');
select nullif(100, 100), nullif(200, 100);

 -- case-when-else-end
 select case 3
	when 1 then '일'
    when 5 then '오'
    when 10 then '십'
    else '모름'
	end as 'CASE연습';

select ascii('A'), char(65);
select bit_length('abc'), char_length('abc'), length('abc');
select bit_length('가나다'), char_length('가나다'), length('가나다');
select lpad('혼자공부', 6, '**'), rpad('혼자공부', 6, '##');
select ltrim('    혼자공부'), rtrim('혼자공부'      ),/*ltrim : 왼쪽 공백제거, rtrim: 오른쪽 공백 제거*/
      trim('      혼자공부        '), trim(both 'ㅋ' from 'ㅋㅋㅋ재미있네요.ㅋㅋㅋ') TRIM, /*trim : 양쪽 공백 제거*/
	  trim(leading 'ㅋ' from 'ㅋㅋㅋ재미있네요.ㅋㅋㅋ') LTRIM,
      trim(trailing 'ㅋ' from 'ㅋㅋㅋ재미있네요.ㅋㅋㅋ') RTRIM;
select substring('대한민국만세', 3, 2); 
select substring_index('cafe.naver.com', '.', 2), substring_index('cafe.naver.com', '.', -2); -- '.' 뒤에나 앞에거 가져오기 (가져올 문자, 조건문자, 가져올 위치와 갯수)
select rand(), floor(1+ (rand()*(7-1)));

select curdate(), curtime(), now(), sysdate();
select adddate('2025-01-01', interval 100 day),
	   adddate('2025-01-01', interval 1 month);
select subdate('2025-01-01', interval 100 day),
	   subdate('2025-01-01', interval 1 month);
select datediff('2025-01-01', now()), timediff('23:23:59', '12:11:10');

/* {"name" : "블랙핑크", "height" : 163}
*/
select json_object('name', mem_name, 'height', height)
as 'json값' from member where height >= 160;

set @json = '{ "member2" : 
[
{"name" : "방탄소년단", "height" :185}, 
{"name" : "비틀즈", "height" :190}, 
{"name" : "투애니원", "height" :163}
] 
}';
select json_valid(@json) as json_valid;
select json_search(@json, 'one', '비틀즈') as json_search;
select json_extract(@json,  '$.member2[2].name') as json_extract; -- 번지에 있는 값 확인
select json_insert(@json, '$.member2[0].mDate', '2022-12-01') as json_insert;
select json_replace(@json, '$.member2[0].name', '서태지와아이들') as json_replace;
select json_remove(@json, '$.member2[0]') as json_remove; 






select  * from buy /*use 생략가능*/
inner join member
on buy.mem_id = member.mem_id
where buy.mem_id='GRL'; 

select mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처'
	from buy inner join member
    on buy.mem_id = member2.mem_id;
    

select a.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처'
	from buy a join member b
    on a.mem_id = b.mem_id;
    
    
select a.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처'
	from buy a 
    inner join member b
    on a.mem_id = b.mem_id 
    order by mem_name;
    
    select distinct a.mem_id, mem_name, addr
    from buy a 
    inner join member b
    on a.mem_id = b.mem_id
    order by mem_name;
    
    select a.mem_id, a.mem_name, a.addr
    from member a 
    where exists(select * from buy b
					where a.mem_id = b.mem_id);
    
    
    select distinct a.mem_id, mem_name, addr, concat(phone1, phone2)'연락처'
    from buy a 
    inner join member b
    on a.mem_id = b.mem_id
    order by mem_name;
    
    select a.mem_id, a.mem_name, b.prod_name, a.addr
    from member a 
    left outer join buy b
    on a.mem_id = b.mem_id
    order by a.mem_id;
    
    
    select b.mem_id, b.mem_name, a.prod_name, b.addr
    from buy a 
    right outer join member bmemtbl
    on a.mem_id=b.mem_id
    order by a.mem_id;
    
    
    -- 구매이력이 없는 회원만 추출하시오.
    select * from member a
    left outer join buy b
    on a.mem_id = b.mem_id
   
    
  union
  select * 
  from member a
  right outer join  buy b
  on a.mem_id =b.mem_id;
  
  select * from buy cross join member;
  
  select count(*) from sakila.inventory;
  select count(*) from world.city;
  select count(*) from sakila.inventory cross join world.city;
  
  create table cross_table
  select * from sakila.actor
  cross join world.country;
  select count(*) from cross_table;
  
  select * from cross_table limit 5;
  
  create table emp_table(emp char(4), manager char(4), phone varchar(8));
  insert into emp_table values ('대표', null, '0000');
  insert into emp_table values ('영업이사', '대표', '1111');
  insert into emp_table values ('관리이사', '대표', '2222');
  insert into emp_table values ('영업과장', '영업이사', '3333');

  select a.emp '사원', b.emp '직속상관' , b.phone'연락처'
  from emp_table a
  inner join emp_table b 
  on a.manager = b.emp;
  
  select emp, phone from emp_table
  union
  select mem_id, addr from member;
  
  
  select mem_name, concat(phone1, phone2) as 전화번호 from member
	where mem_name not in (select mem_name from member where phone1 is null);
    select mem_name, concat(phone1, phone2) as 전화번호 from member
    where mem_name in (select mem_name from member where phone1 is null);
    
    
   -- 스토어즈 프로시저
    drop procedure if exists ifProc1;
    delimiter $$ 
    create procedure ifProc1()
    begin
		if 100 = 100 then 
			select '100은 100과 같아요.';
		          
            end if;
            end $$
	delimiter ;
    call ifproc1();
	
    call ifproc1();
    
  drop procedure if exists ifProc2;
    delimiter $$ 
    create procedure ifProc2()
    begin
		declare num int;
        set num = 200;
		if 100 > num then 
			select '100은 100과 같아요.';
		else 
            select '100은 200과 달라요.';
            
            end if;
            end $$
	delimiter ;
    call ifproc2();
	
    
    drop procedure if exists ifProc3;
    delimiter $$
    create procedure ifproc3()
    begin  -- 중괄호
	declare debutDate DATE;
    declare curDate DATE;
    declare days int;
    select debut_date into debutDate
		from member 
        where mem_id = 'APN'; 
	set curDate = current_date();
    set days = datediff(curDate, debutDate);
    
    if (days/365) >= 5 then
		select concat('데뷔한 지 ', days, '일 지났습니다. 핑순이들 축하합니다!.') massage;
	else
		select concat('데뷔한 지 ', days, '일 밖에 안되었네요. 핑순이들 화이팅!');
    end if;
    end $$
	delimiter ;
    
    call ifproc3();
    
	
	
    CREATE TABLE stdtbl
    (stdName varchar(10) not null primary key,
    addr char(4) not 	null);
    
    create table clubtbl
    (clubName 	varchar(10) not null primary key,
    roomNo char(4) not null);
    
    create table stdclubtbl
    (num int auto_increment not null primary key,
    stdname varchar(10) not null,
    clubname varchar(10) not null,
    foreign key(stdname) references stdtbl(stdname),
    foreign key(clubname) references clubtbl(clubname));
    
    insert into stdtbl values( '김범수', '강남'),
		('성시경', '서울'),
        ('조용필', '경기'),
        ('은지원', '경북'),
        ('바비킴', '서울');
    
    
    insert into clubtbl values ('수영', '101호'),
								('바둑','102호'),
								('축구','103호'),
								('봉사', '104호');
                                
                                
	insert into stdclubtbl values (null, '김범수', '바둑'),
    (null, '김범수', '축구'),
    (null, '조용필', '축구'),
    (null, '은지원', '축구'),
    (null, '은지원', '봉사'),
    (null, '바비킴', '봉사');
    
	
    select s.stdName, s.addr, sc.clubName, c.roomno
    from stdTbl s
    join stdclubtbl sc 
    on s.stdname = sc.stdname
    join clubtbl c
    on sc.clubname =c.clubname
    order by s.stdname;
    
    select sc.clubname, c.roomno, sc.stdname, s.addr
    from stdclubtbl sc
    join stdtbl s
    on sc.stdname = s.stdname
    join clubtbl c
    on sc.clubname = c.clubName
    order by clubName;
    
    drop procedure if exists ifproc3;
    delimiter $$
    create procedure ifproc3()
    begin
		declare point int;
        declare credit char(1);
        set point = 77;
        
        
        if point >= 90 then set credit = 'A';
        elseif point >= 80 then set credit = '8';
        elseif point >= 70 then set credit = 'c';
        elseif point >= 60 then set credit = 'd';
        else set credit = 'F';
        end if;
        
        
        select concat('취득점수 ==> ' , point) 취득점수, 
               concat('학점 ==> ', credit) 학점;
        
        
    end $$ 
    delimiter ;
    call ifproc3();
    
    drop procedure if exists ifproc4;
    delimiter $$
    create procedure ifproc4()
    begin
		declare point int;
        declare credit char(1);
        set point = 77;
        
         case 
		when point >= 90 then set credit = 'A';
		when point >=80 then set credit = 'B';
        when point >=70 then 
                  set credit = 'c';
        when point >= 60 then 
        		set credit = 'd';
		else set credit = 'f';
        end case;
         
        select concat('취득점수 ==> ' , point) 취득점수, 
               concat('학점 ==> ', credit) 학점;
        
        
    end $$ 
    delimiter ;
    call ifproc4();
    
    select b.mem_id '아이디', m.mem_name '이름', sum(b.price * b.amount) '총 구매액', 
		case
			when (sum(b.price*b.amount) >=1500) then '최우수 고객'
            when (sum(b. price*b.amount) >=1000) then '우수 고객'
            when (sum(b. price*b.amount) >=1) then '일반 고객'
            else '유령고객' 
		end as '회원등급'  
		from buy b, member m
        where b.mem_id = m.mem_id 
		group by mem_id
        order by sum(b.price * b.amount) desc;
    
	drop procedure if exists whileproc;
    delimiter $$
    create procedure whileporc()
    begin
    -- 1에서 100까지의 합을 구해 봅시다.
    declare i int;
    declare total int ;
    set i=0;
        set total = 0;
        
        
        mywhile:
    while (i<= 100) do
    if(i%2=0) or (i%3=0)then
    set i = i+1;
    iterate mywhile;
    end if;
   
    if(total>500) then 
    leave mywhile;
    end if; 
    set total = total + i;
   set i = i+1;
   
    end while;
    select '1부터 100까지의 합(2의 배수가 아닌) : ', total;
    end $$
        
        
        
    