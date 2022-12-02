create database marketdb; 
use marketdb; -- markdb를 오픈한다. 



create table marketdb.memeber (
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
mem_number int not null,
addr       char(2) not null, 
phone1 char(3),
phone2 char(8),
height smallint,
debut_date date
);


select * from member;

insert into member values('TWC', '트와이스', 9, '서울', '02', '11111111', '167', '2022.10.19');

INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

create table buy(
num int not null primary key auto_increment,
mem_id char(8) not null,
pord_name char(6) not null,
group_name char(4),
price int not null,
amount smallint not null,
foreign key (mem_id) references member(mem_id));

insert into buy values (null, 'BLK', '지갑', 'null', 30, 2);


INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);


select * from buy;


select  mem_name from member;
select addr, debut_date, mem_name from member;
select addr 주소, debut_date "데뷔 일자", mem_name 이름 from marketdb.member; -- 이름 바꿔서 내용 구하기
select * from member where mem_name="블랙핑크";
select * from marketdb.member where mem_number=4;
select * from marketdb member where height <= 162;
select * from marketdb.member where height >= 165 or mem_number>6;
select * from marketdb.member where height >= 163 and height <=165 ;
select * from marketdb.member where height between 163 and 165;
select * from marketdb.member where  addr='경기' or addr='전남' or addr;
select * from marketdb.member where  addr in('경기', '전남', '경남');
select * from marketdb.member where mem_name like '%녀%';
select * from marketdb.member where mem_name like '__핑크';

select height from marketdb.member where mem_name='에이핑크';
select mem_name, height from marketdb.member where height > 167;
-- select mem_name, height from marketdb.member where height > 
-- (select height from marketdb.member where addr= '경남'); 

select mem_name, height from marketdb.member where height >= any 
	(select height from marketdb.member where addr= '경남');
    
select mem_name, height from marketdb.member where height =
	(select height from marketdb.member where  addr='경남');
    
select mem_name, height from marketdb.member where height
	in (select height from marketdb.member where addr='경남');
    
select * from marketdb.member;
select mem_name from marketdb.member order by mem_name; -- name 순서대로
select * from maeketdb.member order by debut_date;
select * from marketdb.member where addr='경남' order by mem_name;
select * from marketdb.member order by debut_date desc;
select mem_id '아이디', mem_name '이름', debut_date '데뷔일자', height '키'
from marketdb.member  where height >= 162 order by debut_date desc;

select * from marketdb.member where height >= 164
	order by height desc, debut_date asc;  -- 같은 키라면 데뷔일자 순서대로 하겠다.
    
select * from marketdb.member order by height limit 3,2 ;--  height 0번지 부터 2개 읽어와라 

select distinct addr from marketdb.member order by addr;

create table memTBL (
select mem_id, mem_name, addr from member);

select * from memtbl; 

select *from buy;

select mem_id, amount from buy order by mem_id;

select mem_id, sum(amount) from buy group by mem_id;

select mem_id, '회원아이디', sum(price * amount) '총 구매 금액'
	from buy group by mem_id;
    
select mem_id, avg(price *amount) '회원별 구매 금액'
	from buy group by mem_id;
    
select avg(amount) '전체 평균 구매 갯수' from buy;

select mem_id, avg(amount) '평균 구매 갯수'
	from buy group by mem_id;
    
    
select count(*) from marketdb.member;

select count(phone1) from marketdb.member; -- 핸드폰1 을 가지고 있는 사람의 수

select mem_name, max(height), min(height) from marketdb.member
	group by mem_name;
    
    select mem_name, max(height), min(height) from marketdb.member;
    
    
-- 회원별 총 구매 금액 
select mem_id, sum(price * amount) '총 구매금액' from buy group by mem_id
having sum(price * amount) > 1000;

select mem_id, sum(price * amount) '총 구매금액' from buy group by mem_id
having sum(price * amount) > 1000
order by sum(price * amount) desc; 

select num, group_name, sum(price * amount) '총 구매금액' 
from buy 
group by group_name, num
with rollup;
    
select mem_name, height from marketdb.member where height = (select max(height) from marketdb.member)
		or height = (select min(height) from marketdb.member);
        

   