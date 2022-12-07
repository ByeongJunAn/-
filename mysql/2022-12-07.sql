use marketdb;
create table backup_member (
	mem_id 			char(8) primary key,
    mem_name	 	varchar(10),
    mem_number 		int(11),
    addr 			char(2),
    phone1			char(3),
    phone2			char(8),
    height			smallint(6),
    debut_date		date,
    grade			char(20),
    modDate			date,	-- 변경 날짜
    modType			char(2),  -- 변경타입 '수정', '삭제'
    modUser			varchar(256) -- 변경한 사용자
    );
    
drop trigger if exists backupMember;
delimiter ##
create trigger backupMember
		after update
        on member 
        for each row
    begin
    insert into backup_member values(old.mem_id, old.mem_name, old.mem_number, old.addr, old.phone1, old.phone2, old.height,
    old.debut_date, old.grade, curdate(), '수정', current_user());
    
    end ##
    delimiter ;
    
    update member set addr='경기' where mem_id ='GRL';
    select * from backup_member;
    
drop trigger if exists backupMember_del;
delimiter ##
create trigger backupMember_del -- 트리거 이름
		after delete -- 삭제 후에 작동하게 지정
        on member -- 트리거를 부착할 테이블
        for each row -- 각 행마다 적용됨
    begin
    insert into backup_member values(old.mem_id, old.mem_name, old.mem_number, old.addr, old.phone1, old.phone2, old.height,
    old.debut_date, old.grade, curdate(), '삭제', current_user());  -- 트리거 실행 시 작동 되는 코드들
    
    end ##
    
    delimiter ;
    
    
    delete from member where mem_id = 'WMN';
    
        select * from backup_member;
        
drop trigger if exists member_insertTrg;
delimiter ##
create trigger member_insertTrg
	after insert
    on member
    for each row
begin
	signal sqlstate '45000'
		set message_text = '데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었습니다.';
end ##
delimiter ; 


insert into member values('ABC', '에이비씨', 5, '서울', '02', '2563123', 180, '2019-01-01', null);

select * from member;

drop trigger if exists member_beforeInTrg;
delimiter ##
create trigger member_beforeInTrg
	before insert
    on member 
    for each row
begin
	if new.grade = '유령고객' then
		set new.grade = '신규고객';
	end if;
end ##
delimiter ;

drop trigger member_insertTrg;

insert into member values('ABC', '에이비씨', 5, '서울', '02', '2563123', 180, '2019-01-01', '유령고객');

select * from member;

show triggers from marketdb;

drop database if exists triggerdb;
create database if not exists triggerdb;
use triggerdb;

create table orderTbl(
	orderNo int auto_increment primary key,
    userId varchar(5), 
    prodName varchar(5),
    orderAmount int  		-- 주문 수량
    );
    
create table prodTbl(		-- 상품
prodName varchar(5),  		-- 상품 명
account int					-- 재고 수량
);

create table deliverTbl(
	deliverNo int auto_increment primary key,  -- 배송 번호
    prodName varchar(5),	
    account int unique  	-- 배송 수량
    );
    
insert into prodTbl values('사과', 100);
insert into prodTbl values('배', 100);
insert into prodTbl values('귤', 100);

drop trigger if exists orderTrg;
delimiter ##
create trigger orderTrg
	after insert 
    on orderTbl 
    for each row
begin
	update prodTbl set account = account - new.orderAmount 
	where prodName = new.prodName;
end ##

delimiter ;    
    
drop trigger if exists prodTrg;
delimiter ##
create trigger prodTrg
	after update
    on prodTbl
    for each row
begin
	declare orderAmount int;
    set orderAmount = old.account - new.account;
    insert into deliverTbl (prodName, account)
		values(new.prodName, orderAmount);
        
end ##    

delimiter ;

select * from prodTbl;
insert into orderTbl values(null, 'kim', '사과', 10);

select * from orderTbl;
select * from prodTbl;
select * from deliverTbl;

create database keduit;
use keduit;

create table SeoulLocation(
		no int(4) PRIMARY KEY auto_increment,
        title varchar(20),
        titleInfo varchar(200),
        address varchar(50),
        phone varchar(20),
        info varchar(100),
        traffic varchar(200)
        );
        
select * from SeoulLocation;