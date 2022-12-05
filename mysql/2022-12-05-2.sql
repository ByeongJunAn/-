select name, height from member;
    
    create view v_member
    as 
    select mem_id, name, height from member;
    select * from v_member;
    select name, height from v_member 
		where height > 160;
    
    create table buy(
	num int auto_increment not null primary key, 
    user_id char(8) not null,
    pro_name char(6) not null
    );
    
    alter table buy
    add constraint -- 제약조건
    foreign key(user_id) -- 유저 아이디가 포린키야
    references member(mem_id);
    
     
        insert into buy values (null, 'RED', '카메라');
        insert into buy values (null, 'RED', '맥북');
        insert into buy values (null, 'SPC', '노트북');
        
select * from buy;        
        
	select m.mem_id, m.name, m.phone1 국번, b.pro_name
    from buy b
    join member m 
    on b.user_id = m.mem_id;
    
    create view v_memberbuy
	as
       select m.mem_id, m.name, m.phone1 국번, b.pro_name
    from buy b
    join member m 
    on b.user_id = m.mem_id;
    
    select * from v_memberbuy;
    
    desc v_memberbuy;
    
    create view v_viewtest1
    as
    select b.mem_id `Member Id`, 
    m.name as `Member Name`, 
    b.pro_name "Product name",
    concat(m.phone1, m.phone1) as "office phone"
    from buy b
    inner join member m
    on b.mem_id = m.mem_id;
    
    select * from v_viewtest1;
    desc v_viewtest1;
    
    
    select `Member Id`, `Member Name` from v_viewtest1;
    
    drop view v_viewtest1;
    
    show create view v_memberbuy;
    
    
    update v_member set height = 170 where mem_id='RED';
    select *from v_member;
    
    select * from member;
    
    create view v_height160
    as
		select * from member where height>=160
		with check option;
        
    select * from v_height167;
    
    
    insert into v_height167 values ('TRA', '티아라', 167, null) ;
    select * from member;
    insert into v_height167 values('TOB', '텔레토비', 150, "055");
    
    select * from v_height167;
    
    insert into v_height160 values ('DOY', '아기공룡둘리', 160, null);
    
    select * from member;
    select *from v_height160;
    select * from v_height167;
    
    drop table buy, member;
    
    
    -- indeex
    create table table1(
    coll int primary key,
    col2 int,
    col3 int
    );
    use marketdb ;
    show index from table1;
    
    select * from member;
    
    alter table member
		add constraint primary key (mem_id);
        
        	alter table buy drop foreign key buy_ibfk_1;
        
        alter table member drop primary key;
        select *from member;

alter table member add constraint primary key (mem_name);
select * from member;

insert into member values('BTS', '방탄소년단', 8, '서울', '02', '7778888', 185, '2013-01-01');

create table cluster
(mem_id char(8),
mem_name varchar(10)
);

insert into cluster values('TWC', '트와이스'); 
insert into cluster values('BLK', '블랙핑크');
insert into cluster values('WMN', '여자친구');
insert into cluster values('OMY', '오마이걸');
insert into cluster values('GRL', '소녀시대');
insert into cluster values('ITZ', '잇지');
insert into cluster values('RED', '레드벨벳');
insert into cluster values('APN', '에이핑크');
insert into cluster values('SPC', '우주소녀');
insert into cluster values('MMU', '마마무');


alter table cluster
	add constraint primary key(mem_id);
    
    select * from cluster;
    
    create table second (
    mem_id char(8), 
    mem_name varchar(10)
    );
    
    
    insert into second  values('TWC', '트와이스'); 
insert into second  values('BLK', '블랙핑크');
insert into second  values('WMN', '여자친구');
insert into second  values('OMY', '오마이걸');
insert into second  values('GRL', '소녀시대');
insert into second  values('ITZ', '잇지');
insert into second  values('RED', '레드벨벳');
insert into second  values('APN', '에이핑크');
insert into second  values('SPC', '우주소녀');
insert into second  values('MMU', '마마무');


select * from second;
alter table second 
 add constraint unique (mem_id);
 
 create index idx_member_addr
	on member(addr); 
select * from member;

show index from member;

show table status like 'member';
analyze table member;
show table status like 'member';
 
 
 
    