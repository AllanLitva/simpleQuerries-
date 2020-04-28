
drop table supplier;
drop table part;
drop table SP;


create table supplier (
s#    char(4),
sname varchar2(10),
status   int,
city varchar2(20),
primary key (s#));


create table part (
p#    char(4),
pname varchar2(10),
color   varchar2(10),
weight  float, 
city varchar2(20),
primary key (p#));






create table SP (
s#    char(4),
p#    char(4),
QTY  int,
primary key (s#,p#),
foreign key (s#) references supplier (s#),
foreign key (p#) references part (p#));


insert into supplier values ('S1', 'Smith', 20, 'London');
insert into supplier values ('S2', 'Jones', 30, 'Paris');
insert into supplier values ('S3', 'Blake', 30, 'Paris');
insert into supplier values ('S4', 'Litva', 20, 'London');
insert into supplier values ('S5', 'Adams', 30, 'Athens');

insert into part values ('P1', 'Nut', 'Red', 12.0, 'London');
insert into part values ('P2', 'Bolt', 'Green', 17.0, 'Paris');
insert into part values ('P3', 'Nail', 'Red', 12.0, 'Paris'); 
insert into part values ('P4', 'Screw', 'Red', 14.0, 'London');
insert into part values ('P5', 'Cam', 'Blue', 12.0, 'Paris');
insert into part values ('P6', 'Cog', 'Red', 19.0, 'London');

insert into SP values ('S1', 'P1', 300);
insert into SP values ('S1', 'P2', 200);
insert into SP values ('S1', 'P3', 400);
insert into SP values ('S1', 'P4', 200);
insert into SP values ('S1', 'P5', 100);
insert into SP values ('S1', 'P6', 100);
insert into SP values ('S2', 'P1', 300);
insert into SP values ('S2', 'P2', 400);
insert into SP values ('S2', 'P3', 500);
insert into SP values ('S3', 'P2', 200);
insert into SP values ('S3', 'P3', 200);
insert into SP values ('S3', 'P4', 300);
insert into SP values ('S4', 'P2', 300);
insert into SP values ('S4', 'P3', 400);
commit;





select pname 
from part p, supplier s, SP sp 
where s.sname = 'Litva' and sp.s# = s.s# and sp.p# = p.p#;



select sname 
from supplier s, part p, SP sp 
where p.pname = 'Bolt' and 
sp.p# = p.p# and s.s# = sp.s#; 



select sname from 
supplier s, SP sp
where s.s# = sp.s# 
and sp.QTY > 400;



select distinct sname from
supplier s, part p, SP sp 
where p.color = 'Blue' or p.color = 'Green' 
and p.p# = sp.p# and s.s# = sp.s#; 



select distinct sname 
from supplier s, part p1, part p2, SP sp1, SP sp2 
where p1.color = 'Blue' and p2.color = 'Green' and sp1.p# = p1.p# 
and sp2.p# = p2.p# and sp1.s# = s.s# and sp2.s# = s.s#;



select sname, pname 
from supplier s, part p 
where not exists ( select * from sp where 
sp.s# = s.s#  and sp.p# = p.p#);  


select sname from supplier s
where not exists(select * from SP where SP.s# = s.s#);


select sname from 
supplier s where not exists( 
select * from part p where not exists( 
select * from SP sp where p.p# = SP.p# and s.s# = sp.s#));


select s1.sname from supplier s1
where s1.sname != 'Litva' and not exists( 
select p.p# from part p, supplier s, SP sp 
where s.sname = 'Litva' and s.s# = sp.s# and p.p# = sp.p#
minus 
select p.p# 
from part p, SP sp 
where s1.s# = sp.s# and p.p# = sp.p#);


select sname, count(*), sum(QTY) 
          from supplier natural join SP 
          group by sname;
