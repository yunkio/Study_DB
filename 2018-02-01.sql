--��ü �μ����� ����� ���� �μ��� ���

select department_name, department_id
from departments
where department_id=(Select department_id
                    from departments
                    minus
                    select department_id
                    from employees);

select d.department_name, d.department_id
from departments d
left join employees e on d.department_id = e.department_id
where e.last_name is null;


----------------chapter 10-----------------
-------------------------------------------

select * from user_constraints;

create table member(
 user_id VARCHAR2(20) primary key,
 user_name VARCHAR2(20) not null,
 age NUMBER(3)
 );
 
 insert into member(user_id,user_name,age) values('taiji', '������', 42);
 insert into member(user_id,user_name,age) values('crom', '����ö', 45);
 insert into member(user_id,user_name,age) values('jaeha', '������', '48');
 
 drop table member purge;
 
 create table member(
 user_id VARCHAR2(20) constraint mem_usr_id_pk primary key,
 user_name VARCHAR2(20) constraint mem_usr_nm_nn not null,
 age NUMBER(3)
 );
 

create table member(
 user_id    VARCHAR2(20),
 user_name  VARCHAR2(20),
 age        NUMBER(3),
 email      varchar2(50),
 constraint mem_usr_id_pk primary key(user_id),
 constraint mem_usr_nm_nn check(user_name is not null),
 constraint mem_email_uk unique(email)
 );
 
 -- not null ���������� table �������� �� �� ����, is not null�� �����
 
 
create table board (
no number,
title       varchar2(100),
content     varchar2(4000),
user_id     varchar2(20),
    constraint brd_no_pk primary key(no),
    constraint brd_title_nn check(title is not null),
    constraint brd_usr_id_fk foreign key(user_id)
                             references member(user_id)
);



-----------sequence------


create sequence dept_deptid_seq
increment by 10
start with 120
maxvalue 200
cache 5
nocycle;

select dept_deptid_seq.nextval from dual;
select dept_deptid_seq.currval from dual;


--------------------------

insert into board(no, user_id, title, content)
values(brd_no_seq.nextval, 'taiji', '�� �˾ƿ�', '�� ���� �帣�� �帣��');

insert into board(no, user_id, title, content)
values(brd_no_seq.nextval, 'crom', '�״뿡��', '�����ڰ� ��ư��� �ð� �ӿ���');

select * from board;

select b.no as �۹�ȣ, b.title as ����, b.content as ����, m.user_name||'('||b.user_id||')' as �۾���
from board b
join member m on b.user_id = m.user_id
order by b.no desc;

select b.no as �۹�ȣ, b.title as ����, b.content as ����, m.user_name||'('||b.user_id||')' as �۾���
from board b
join member m on b.user_id = m.user_id
where m.user_name like '%&&�˻�%'
or    b.content like '%&&�˻�%'
or    b.title like '%&&�˻�%'
order by b.no desc
;
undefine �˻�;

insert into board(no, user_id, title, content)
values (brd_no_seq.nextval, 'jaeha', '���� ���������� ����', '��������');

insert into board(no, user_id, title, content)
values (brd_no_seq.nextval, 'taiji', '��', '����');

insert into board(no, user_id, title, content)
values(brd_no_seq.nextval, 'crom', '��', '��');


-----------------------
-------exam/exam--------
-----------------------


create table dept(
 deptno     NUMBER(3),
 dname      VARCHAR2(30),
 loc        VARCHAR2(10),
 constraint dept_dno_pk primary key(deptno),
 constraint dept_dn_nn check(dname is not null)
 );
 
 create table dept(
 deptno     NUMBER(3) constraint dept_dno_pk primary key,
 dname      VARCHAR2(30) not null,
 loc        VARCHAR2(10),
 );
 
 create table emp(
 empno      NUMBER(4),
 ename      VARCHAR2(30),
 hp         VARCHAR2(11),
 salary     NUMBER,
 deptno     number(3),
 constraint emp_eno_pk primary key(empno),
 constraint emp_en_nn check(ename is not null),
 constraint emp_hp_uq unique(hp),
 constraint emp_sr_ck check(salary >= 1200000)  ,
 constraint emp_dno_fk foreign key(deptno)
                       references dept(deptno)
);

create table emp(
 empno      NUMBER(4) constraint emp_eno_pk primary key,
 ename      VARCHAR2(30) not null,
 hp         VARCHAR2(11) constraint emp_hp_uq unique,
 salary     NUMBER constraint emp_sr_ck check(salary >= 1200000),
 deptno     number(3) constraint emp_dno_fk
                       references dept(deptno)
);


create sequence emp_empno_seq;

create sequence dept_deptno_seq
increment by 10
start with 10;

insert into dept(deptno, dname, loc)
values (dept_deptno_seq.nextval, '���', '����');
insert into dept(deptno, dname, loc)
values (dept_deptno_seq.nextval, '������', '�λ�');
insert into dept(deptno, dname, loc)
values (dept_deptno_seq.nextval, '���ߺ�', '����');

insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '����ö', '01011112222', 5000000, 10);
insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '������', '01011112223', 6000000, 20);
insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '������', '01011112224', 4000000, 30);
insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '����', '01011112225', 3000000, 10);

select * from emp;
select * from dept;




select      e.empno as �����ȣ, e.ename as �����, e.hp as ��ȭ, replace(to_char(salary, '999999,999'), '0,000', '��') as �޿�, d.dname as �μ�, d.loc as ����
from        emp e 
join        dept d on e.deptno=d.deptno;



-------------------------------------------------
----------------------11��------------------------
-------------------------------------------------
---n1/n1----

create view emp_test
as
select last_name,job_id, department_id from employees;

select * from emp_test;

create or replace view emp_test
as
select employee_id, last_name,job_id, department_id from employees;
--�䰡 ������ ����� ������ ����
--������ drop

create view empvu80
as select *
where department_id=80;

desc empvu80;
select * from empvu80;

------admin-------

grant select, insert, update on emp_test to scott;


------scott------

update n1.emp_test set department_id=80 where employee_id=144;
commit;

select * from n1.emp_test where employee_id=144;

------n1------
create index emp_last_name_idx
on employees(last_name);


-----admin----
grant create synonym to n1;

-----n1-----
create synonym ��� for employees;

select * from ���;

commit;

