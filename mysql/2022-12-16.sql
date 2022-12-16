use keduit;

create table member(
	name varchar(10),
    userid varchar(10) primary key,
    pwd varchar(10),
    email varchar(20),
    phone char(13),
    admin int(1) default 0 -- 0:사용자, 1:관리자
    );
    
    insert into member values("이소미", "somi","1234","gmd@naver.com","010-2362-5157",0),
                   ("하상오", "sang12","1234","ha12@naver.com","010-5629-8888",1),
                         ("김윤승", "light","1234","young1004@naver.com","010-9999-8282",0);
                         
                         
create table member2(
	name varchar(20),
    price int(8),
    description varchar(100),
    );
    
                         
select * from member;