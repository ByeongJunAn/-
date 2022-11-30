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
select *from marketdb.member where height between 163 and 165;
select *form  ,c