/*create user madang@'%' -- 모든곳에서 가능하다 */
create user madang@localhost identified by 'madang';

create user mdguest@localhost identified by 'mdguest';
create user mdguest2@localhost identified by 'mdguest2';

grant all privileges on *.* to madang@localhost with grant option;
show grants for madang@localhost;
