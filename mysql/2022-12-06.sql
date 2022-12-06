create unique index idx_member_mem_number
on member(mem_number);
create unique index idx_member_mem_name
on member(mem_name);
show index from member;
select * from member;
show table status like 'member';
insert into member values ('MOO', '마마무', 2, '태국', '001', '12341234', 162, '2022.10.10');

alter table member drop primary key;

alter table member add constraint primary key(mem_id);

analyze table member;
show index from member;



select *from member;
select mem_id, mem_name, addr from member;
select mem_id, mem_name, addr from member where mem_name='에이핑크';
select mem_id, mem_name, addr from member where height = '162'; 

create index idx_member_mem_number
	on member(mem_number); 
analyze table member;
select mem_name, mem_number from member where mem_number >= 7;

select * from member
where mem_number >=7;

select * from member
where mem_number >=1;

select * from member
where mem_number *2 >= 14; -- 필드쪽에 연산을 넣으면 인덱스를 안타지만

select * from member
where mem_number >= 14/2; -- 결과쪽에 연산을 넣으면 인덱스로 가져온다.alter

show index from member;
drop index idx_member_mem_name on member;
drop index idx_member_addr on member;
drop index idx_member_mem_number on member;
show index from member;

select table_name, constraint_name
from information_schema.referential_constraints
where constraint_schema = 'marketdb';


-- 프로시저
drop procedure if exists user_proc1;
delimiter $$
create procedure user_proc1(in userName varchar(10))
begin 
select * from member where mem_name = userName;
end $$
delimiter ;

call user_proc1('방탄소년단');

drop procedure if exists user_proc2;
delimiter $$
create procedure user_proc2(
	in userNumber int, 
    in userHeight int)
    begin
    select * from member
		where mem_number > userNumber and height > userHeight;
    end $$
    delimiter ;
    
    call user_proc2(6, 165);
    
    drop procedure if exists user_proc3;
    delimiter $$
    create procedure user_proc3(
		in txtValue char(10),
        out outValue int)
    begin
    insert into noTable values(null, txtValue);
    select max(id) into outValue from noTable;
    end$$
    delimiter ; 
    
    desc noTable;
    create table if not exists noTable(
    id int auto_increment primary key,
    txt char(10)
    );
    
    call user_proc3('테스트1', @myValue);
    
    
    select concat('입력된 값 => ' , @myValue);
    select * from noTable;
    
    drop procedure if exists ifelse_proc;
    delimiter $$
    create procedure ifelse_proc(
		in mem_name char(5)
    )
    begin
    declare debutYear int; -- declare: 변수 선언
    select year(debut_date) into debutYear
      from member m
      where m.mem_name=mem_name;
    
    if (debutYear >= 2015) then
    
    select '신인이시군요';
    else select '수고하셨어요';

    end if;

    end $$
    delimiter ;
    
    call ifelse_proc('에이핑크');
    
    
    
    
    drop table if exists guguTable;
    
    create table guguTable(
    txt varchar(100)
	);
    
    drop procedure if exists whileproc;
    delimiter $$
    create procedure whileProc()
    begin
		declare str varchar(100);
		declare i Int; -- 구구단 앞자리
		declare k int; -- 구구단 뒷자리
		set i =2;
		set str = '';
        set k=1;
        while (k<10) do
        set str = concat(str, ' ',i , 'x', k, '='. i*k);
        set k = k+1;
        end while;
        set i = i + 1 ;
        insert into gugutable values(str);
        end while;
        end $$
         delimiter ;
       					
		call whileproc();
		select * from guguTable;
        
        select routine_name, routine_definition
			from information_schema.routines
            where routine_schema = 'marketdb' 
            and routine_type = 'PROCEDURE';
            
		select parameter_mode, parameter_name, dtd_identifier
			from information_schema.parameters
            where specific_name = 'user_proc3'; 
            
		show create procedure marketdb.user_proc3;

		
        -- 동적sql 활용
drop procedure if exists dynamic_proc;
delimiter $$
create procedure dynamic_proc(
	in tableName varchar(20))
begin
	set @sqlQuery = concat('select * from ' , tableName);
    prepare myQuery from @sqlQuery;
    execute myQuery;
    deallocate prepare myQuery;
end $$
delimiter ;		        
                
call dynamic_proc('buy');
    
  
set global log_bin_trust_function_creators = 1;

drop function if exists sumFunc;
delimiter $$
create function sumFunc(number1 int, number2 int)
		returns int
    begin
		return number1 + number2;
    end$$
delimiter ;

select sumFunc(200, 500) as 'total';

drop function if exists calcYearFunc;
delimiter $$
create function calcYearFunc(debYear int)
	returns int
begin
	declare runYear int;
    set runYear = year(curdate()) - debYear;
	return runYear;
end$$

delimiter ;

select calcYearFunc(2007) as '활동횟수';

select calcYearFunc(2007) into @debut2007;
select calcYearFunc(2013) into @debut2013;
select @debut2007 - @debut2013 as '2007와 2013의 차이';
select mem_id, mem_name, calcYearFunc(year(debut_date))
	as '활동횟수' from member;
    
show create function calcYearFunc;
drop function calcYearFunc;

-- 커서 

drop procedure if exists cursor_proc;
delimiter $$
	create procedure cursor_proc()
    begin
		declare memNumber int;
        declare cnt int default 0;
        declare totNumber int default 0;
        declare endOfRow boolean default false;
        
        declare memberCursor cursor for select mem_number from member;
            
		declare continue handler
			for not found set endOfRow = true; -- 핸들러가 not found 일때 true로
            
		open memberCursor;
        
        cursor_loop: LOOP
			fetch memberCursor into memNumber;
			if endOfRow then -- endofrow가 트루이면
				leave cursor_loop; -- 커서루프를 브레이크 해줘
			end if;
            
            set totNumber = totNumber + memNumber;
            set cnt = cnt + 1; -- true가 아니면  위의 과정을 계속 반복 해줘
            
            
            end loop cursor_loop;
            select (totNumber / cnt) as '평균 인원수';
		close memberCursor;
    end $$
delimiter ;

call cursor_proc();



-- 멤버들의 평균 키 구하기

drop procedure if exists cursor_proc_height;
delimiter $$
	create procedure cursor_proc_height()
    begin
		declare memNumber int;
        declare cnt int default 0;
        declare totNumber int default 0;
        declare endOfRow boolean default false;
        
        declare memberCursor cursor for 
			select height from member;
            
		declare continue handler
			for not found set endOfRow = true; -- 핸들러가 not found 일때 true로
            
		open memberCursor;
        
        cursor_loop: LOOP
			fetch memberCursor into memNumber;
			if endOfRow then -- endofrow가 트루이면
				leave cursor_loop; -- 커서루프를 브레이크 해줘
			end if;
            
            set totNumber = totNumber + memNumber;
            set cnt = cnt + 1; -- true가 아니면  위의 과정을 계속 반복 해줘
            
            
            end loop cursor_loop;
            select (totNumber / cnt) as '평균 키';
		close memberCursor;
    end $$
delimiter ;

call cursor_proc_height();



drop procedure if exists gradeProc;
delimiter $$
create procedure gradeProc()
begin
	declare id varchar(10);
    declare hap bigint;
    declare userGrade char(10);
    
    declare endOfRow boolean default false;
    declare userCursor cursor for 
		select m.mem_id, sum(price * amount)
			from buy b
            right outer join member m
            on b.mem_id = m.mem_id
            group by m.mem_id, m.mem_name;
            
	declare continue handler for not found set endOfRow = true;
    
    open userCursor;
    
    grade_loop: loop
		fetch userCursor into id, hap;
        if endOfRow then
			leave grade_loop;
		end if;
        case
			when (hap >= 1500 ) then set userGrade = '최우수 고객';
            when (hap >= 1000 ) then set userGrade = '우수 고객';
            when (hap >= 1) then set userGrade = '일반 고객';
			else set userGrade = '유령 고객';
        end case; 
		update member set grade = userGrade where mem_Id = id;
        end loop grade_loop;
    
end $$

delimiter ;



alter table buy
	add constraint foreign key(mem_id) references member(mem_id);
alter table member
	add column grade char(20); 

select * from member;
select * from buy;

call gradeProc();

-- 트리거
USE marketdb;
CREATE TABLE IF NOT EXISTS trigger_table(id INT, txt VARCHAR(10));
INSERT INTO trigger_table VALUES(1, '레드벨벳');
INSERT INTO trigger_table VALUES(2, '잇지');
INSERT INTO trigger_table VALUES(3, '블랙핑크');

DROP TRIGGER IF EXISTS myTrigger;
DELIMITER $$
CREATE TRIGGER myTrigger
	AFTER DELETE
	ON trigger_table 
    FOR EACH ROW -- 각 row 마다 주겠다.
BEGIN
	SET @msg = '가수 그룹이 삭제됨' ; 
END $$

DELIMITER ;

SET @msg= '';
INSERT INTO trigger_table VALUES(4, '마마무');
SELECT @msg;
UPDATE trigger_table SET txt='블핑' WHERE id=3;
SELECT @msg;
DELETE FROM trigger_table WHERE id=4;
SELECT @msg;

