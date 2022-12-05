create database naver_db;
use naver_db;
create table member  (
mem_id char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null /*unsigned: 음수를 쓸 필요 없을때*/
);

desc member;

drop table if exists member;
create table member 
(mem_id char(8) not null,
mem_name varchar(10) not null,
height tinyint unsigned null,
primary key(mem_id)
);

create table member
(mem_id char(8) not null,
mem_name varchar(10) not null,
height tinyint unsigned null
);

alter table member 
  add constraint 
  primary key(mem_id);
  
  create table product (
	proCode char(3) not null,
    proId char(4) not null,
    proDate Date not null,
    proCur char(10) null
    ); 
    
    alter table product 
    add constraint pk_product_proCode_proId primary key (proCode, proId);
    
create table buy (
 num int auto_increment not null primary key,
 mem_id char(8) not null,
 pro_name char(6) not null,
 foreign key(mem_id) references member(mem_id)
 );
 
 drop table if exists buy;
 create table buy(
	num int auto_increment not null primary key, 
    user_id char(8) not null,
    pro_name char(6) not null
    );
    
    alter table buy
    add constraint -- 제약조건
    foreign key(user_id) -- 유저 아이디가 포린키야
    references member(mem_id);
    
    insert into member values('BLK', '블랙핑크', 163);
    insert into buy values(null, 'BLK', '카메라');
    insert into buy values(null, 'BLK', '맥북');
    update buy set user_id = 'pink' where user_id='BLK';
    update member set mem_id = 'pink' where mem_id='BLK';
    
    insert into member values('KBS', '김범수', 175);
    
    update buy set user_id = 'KBS' where user_id='BLK';
    
    alter table buy
		add constraint
        foreign key(user_id) references meber(mem_id)
        on update cascade
        on delete cascade;
        
        select * from buy;
        select * from member;
           
    insert into member values('BLK', '블랙핑크', 163);
    insert into buy values(null, 'BLK', '카메라');
    insert into buy values(null, 'BLK', '맥북');
    update buy set user_id = 'pink' where user_id='BLK';
    update member set mem_id = 'pink' where mem_id='BLK';
    
    delete from buy where pro_name='맥북'; 
    
    delete from member where mem_id='KBS';
    
    
    drop table if exists buy;
    create table buy (
		num  int auto_increment not null primary key,
        mem_id char(8) not null,
        pro_name char(6) not null
        );
        
        alter table buy
        add constraint 
        foreign key (mem_id) references member(mem_id)
        on update cascade
        on delete cascade;
        
        alter table buy
        drop foreign key buy_ibfk_2;
        
        insert into buy values (null, 'RED', '카메라');
        insert into buy values (null, 'RED', '맥북');
        insert into buy values (null, 'SPC', '노트북');
        
        delete from member where mem_id='BLK';
        select * from member;
        select * from buy;
        
        insert into member values('BTS', '방탄소년단', 185);
        update buy set mem_id = 'BTS' where mem_id='KBS';
        update member set mem_id='BTS222' where mem_id='BTS';
        
        drop table if exists buy, member;
        
        create table member 
        (mem_id  char(8) not null primary key,
        mem_name varchar(10) not null,
        height tinyint unsigned null,
        email char(30) null unique
        );
        
        insert into member values('BLK', '블랙핑크', 163, 'pink@gmail.com');
        insert into member values('TWC', '트와이스', 167, null);
        insert into member values('APN', '에이핑크', 164, 'pink@gmail.com');
        
        drop table if exists member;
        
        create table member(
        mem_id char(8) not null primary key,
        mem_name varchar(20) not null,
        height int unsigned null check (height >= 100),
        phone1 char(3) null
        );
        
        insert into member values('BLK', '블랙핑크', 163, null);
        insert into member values('TWC', '트와이스', 99, null); -- 위에서 check로 height>=100 이여야 하므로 범위를 벗어나 실행 불가
        
        alter table member
        add constraint
        check(phone1 in('02', '031', '032', '054', '055', '061')); -- in: 괄호 안에 있는 애들만 해당 됨
        
        insert into member values('OMY', '오마이걸', 167, '010');
        
        drop table if exists member;
        create table member (
			mem_id char(8) not null primary key,
            mem_name varchar(10) not null,
            height tinyint unsigned null default 160, -- 널도 되고 160도 될 수 있다.
            phone1 char(3) null
            );
        
        
        alter table member 
			alter column phone1 set default '02';
            
            insert into member values('RED', '레드벨벳', 161, '054');
            select * from member;
            insert into member values('SPC', '우주소녀', default, default); -- 위에서 키 160을 디폴트로, 전화번호 02를 디폴트로 줬었다.
            
            alter table member 
				add addr varchar(3) null default '서울'; -- 열 추가
			alter table member
            drop column addr;
		
			alter table member 
				change column mem_name name varchar(20) null; 
                select * from member;
                
	