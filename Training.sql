--creating table 'emp_copy' as same as inbuilt emp table
create table emp_copy as select * from emp where 1=2;
--show emp_copy table structure
describe emp_copy;
--show emp_copy table data.note no data in table only structure exists because of 1=2 in where clause
select * from emp_copy;
--now insert data into table emp_copy
insert into emp_copy(empno,ename,job,hiredate,sal,comm,deptno)
values(10,'abc','salesman',to_date('12-04-2017','DD-MM-YYYY'),1500,0.2,10);

insert into emp_copy(empno,ename,job,hiredate,sal,comm,deptno)
values(11,'xyz','salesman',to_date('13-06-2017','DD-MM-YYYY'),4500,0.3,10);

insert into emp_copy(empno,ename,job,hiredate,sal,comm,deptno)
values(12,'pqr','director',to_date('19-09-2017','DD-MM-YYYY'),9500,0.9,11);

insert into emp_copy(empno,ename,job,hiredate,sal,comm,deptno)
values(13,'rst','associate',to_date('12-05-2018','DD-MM-YYYY'),6590,0.2,11);
--insert more than one row at a time as follows

insert all
into emp_copy values(14,'mno','associate',13,to_date('22-05-2019','DD-MM-YYYY'),6010,0.5,11)
into emp_copy values(15,'lmn','associate',12,to_date('29-03-2020','DD-MM-YYYY'),5000,0.5,10)
into emp_copy values(16,'hij','salesman',12,to_date('27-06-2019','DD-MM-YYYY'),1100,null,11)
into emp_copy values(17,'efg','developer',10,to_date('20-05-2021','DD-MM-YYYY'),6000,0.5,13)
into emp_copy values(18,'opq','tester',11,to_date('30-05-2021','DD-MM-YYYY'),500,0.6,13)
into emp_copy values(19,'qrs','associate',11,to_date('02-07-2019','DD-MM-YYYY'),2500,null,11)
into emp_copy values(20,'stu','tester',14,to_date('31-10-2017','DD-MM-YYYY'),6010,null,13)
into emp_copy values(21,'def','developer',16,to_date('07-04-2017','DD-MM-YYYY'),1000,0.9,12)
into emp_copy values(22,'klm','president',18,to_date('01-12-2014','DD-MM-YYYY'),1200,0.8,14)
into emp_copy values(23,'nop','finance',20,to_date('22-05-2016','DD-MM-YYYY'),910,0.1,10)
into emp_copy values(24,'uvw','account',23,to_date('22-05-2013','DD-MM-YYYY'),1700,null,10)
select * from dual;

--change column name sal to salary using alter command
alter table emp_copy rename column sal to salary;
--change column salary data width from number(7,2) to number(8,2)
alter table emp_copy modify salary number(8,2);
--add one column name 'address' to emp_copy
alter table emp_copy add address varchar2(10);
--update salary of employee 'xyx' from 4500 to 5500
alter table emp_copy drop column address;
update emp_copy set salary = 5500 where ename = 'xyz';

--remove all data permanently from emp_copy table but structure of table should be exists using trunc command
truncate table emp_copy;
--even if we perform rollback now we can't retrive data which has deleted before using truncate command
--now delete particular row from emp_copy.ex: delete one record from table whose empid is 11
delete from emp_copy where empno = 11;
--but we can retrive data which was lost by delete command using rollback
rollback;
--check now table
select * from emp_copy;
--now,remove all data but not permanently from emp_copy table and structure of table should be exists using delete command
delete from emp_copy;
--but same here all data can be retrived back using rollback as below
rollback;
--now check table.all data retrived.

--retrive all employees data who are working in department no 10
select * from emp_copy where deptno = 10;
--retrive all employee data who doen't have any commission
select * from emp_copy where comm is null;
--retrive all distinct job profiles from emp_copy table
select distinct job from emp_copy;
--find total salary of employees from table
select sum(salary+salary*nvl(comm,0)) from emp_copy;

--inserting not null constraint to a column 'deptno' of emp_copy.Note we must use modify keyword
alter table emp_copy modify deptno not null;

--to understand constraints in a better way . Lets create a table name 'school'

create table school(
s_name varchar2(10),
teachers number,
students number,
address varchar2(10),
courses number,
s_rank number
);

desc school;
select * from school;
--inserting unique constraint to a column salary of school table
alter table school add constraint "salary_uk" unique(s_rank);
insert into school values('abc',40,50,'chennai',5,1);
insert into school values('ac',4,5,'ai',9,1); -- error bcz rank are same as previous
insert into school values('atc',46,40,'hyd',5,2);
insert into school values('crt',30,20,'baglore',8,3);
--inserting primary key constraint to a column s_name of school table
alter table school add constraint "s_name_pk" primary key(s_name);
--to understand foreign key.lets create another tabel
create table school_analysis(
s_name varchar2(10),
profit number
);
--now inserting foreign key to column s_name of school_analysis table
alter table school_analysis add constraint "s_name_fk" foreign key(s_name) references school(s_name);

drop table school purge;
drop table school_analysis purge;

--joins concept
--create table dept_copy 
create table dept_copy as select * from dept;
--show table dept_copy
select * from dept_copy;
--create table emp_copy

create table emp_copy as select * from emp;
--show emp_copy
select * from emp_copy;

--eqii join
select e.empno,e.ename,d.dname,d.deptno from emp_copy e,dept_copy d where e.deptno = d.deptno;
select e.empno,e.ename,d.dname,d.deptno from emp_copy e inner join dept_copy d on e.deptno = d.deptno;
--natural join
select * from emp e natural join dept d ;
--cartesian product join
select * from emp,dept;
--cross join
select * from emp cross join dept ;
--left join
select e.empno,e.ename,d.dname,d.deptno from emp e,dept d where e.deptno = d.deptno(+);
select e.empno,e.ename,d.dname,d.deptno from emp e left outer join dept d on e.deptno = d.deptno;
--right join
select e.empno,e.ename,d.dname,d.deptno from emp e,dept d where e.deptno(+) = d.deptno;
select e.empno,e.ename,d.dname,d.deptno from emp e right outer join dept d on e.deptno = d.deptno;
--full outer join
select e.empno,e.ename,d.dname,d.deptno from emp e full outer join dept d on e.deptno = d.deptno;
--self join
select worker.empno,worker.ename worker,manager.ename manager,worker.hiredate,worker.sal
from emp_copy worker,emp_copy manager where worker.mgr = manager.empno;

--views concept

create view example as select ename,sal from emp_copy;

select * from example;
--sequence creation
create  sequence num1 start with 8000 increment by 1 maxvalue 9000 nocycle;

select num1.currval from dual;

--create synonym

create synonym ep for emp_copy;
select * from ep;

--create index on column ename of emp_copy
create index idx on emp_copy(ename);
--numeric functions
select round(1544.4983,-3) from dual;

select trunc(2387.14,-3) from dual; --add zeros to left of decimal for better understand

--string function
select instr('saikishore','s',1,2) from dual;

select translate ('hi hello xyzab','xyzab','Manoj') from dual; 
select last_day(sysdate) from dual; 
select round(to_date('16-FEB-2020'),'mon') from dual; 

select trunc(to_date('16-dec-2020'),'year') from dual;
--trucate of any date with respect to month goes to 1st date of month
--trucate of any date with respect to year goes to 1st date of year
select current_date,current_timestamp from dual; 

select * from emp_copy;

--plsql
set serveroutput on;
declare
e_name varchar2(10);
e_sal number(10,2);
e_no number;
e_hiredate date;
cursor c is select ename,sal,empno,hiredate from emp_copy ;
begin
open c;
loop
fetch c into e_name,e_sal,e_no,e_hiredate;
exit when c%notfound;
dbms_output.put_line(e_name||e_sal||e_no||e_hiredate );
end loop;
close c;
end;
/
set serveroutput on;
declare
e_name emp_copy.ename%type;
e_sal emp_copy.sal%type;
e_no emp_copy.empno%type;
e_hiredate emp_copy.hiredate%type;
cursor c is select ename,sal,empno,hiredate from emp_copy ;
begin
open c;
loop
fetch c into e_name,e_sal,e_no,e_hiredate;
exit when c%notfound;
dbms_output.put_line(e_name||e_sal||e_no||e_hiredate );
end loop;
close c;
end;
/

set serveroutput on;
declare
rcd emp_copy%rowtype;
cursor c is select empno,ename,job,mgr,hiredate,sal,comm,deptno from emp_copy ;
begin
open c;
loop
fetch c into rcd;
exit when c%notfound;
dbms_output.put_line(rcd.ename||rcd.sal||rcd.empno||rcd.hiredate);
end loop;
close c;
end;
/
select * from emp_copy;
set serveroutput on;
declare
rcd emp_copy%rowtype;
cursor c is select * from emp_copy ;
begin
open c;
loop
fetch c into rcd;
exit when c%notfound;
dbms_output.put_line(rcd.ename||rcd.sal||rcd.empno||rcd.hiredate);
end loop;
close c;
end;
/
--creating triggers
create or replace trigger st_emp_copy 
BEFORE insert or update or delete
on emp_copy
for each row
enable
declare
user_name varchar2(10);
begin
select user into user_name from dual;
if INSERTING then
dbms_output.put_line('inserted by'||user_name);
elsif UPDATING then
dbms_output.put_line('updating by'||user_name);
elsif DELETING then
dbms_output.put_line('deleting by'||user_name);
end if;
end;
/
select * from emp_copy;
delete from emp_copy where deptno = 10;
--implicit cursor example
declare
rowcount number;
begin
update emp_copy set sal = 2000 where deptno =30;
if sql%notfound then
dbms_output.put_line('none of rows are updated');
elsif sql%found then
rowcount := sql%rowcount;
dbms_output.put_line(rowcount||' rows are updated');
end if;
end;
/