--전체 부서에서 사원이 없는 부서를 출력

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
 
 insert into member(user_id,user_name,age) values('taiji', '서태지', 42);
 insert into member(user_id,user_name,age) values('crom', '신해철', 45);
 insert into member(user_id,user_name,age) values('jaeha', '유재하', '48');
 
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
 
 -- not null 제약조건은 table 레벨에서 줄 수 없음, is not null로 줘야함
 
 
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
values(brd_no_seq.nextval, 'taiji', '난 알아요', '이 밤이 흐르고 흐르면');

insert into board(no, user_id, title, content)
values(brd_no_seq.nextval, 'crom', '그대에게', '숨가쁘게 살아가는 시간 속에도');

select * from board;

select b.no as 글번호, b.title as 제목, b.content as 내용, m.user_name||'('||b.user_id||')' as 글쓴이
from board b
join member m on b.user_id = m.user_id
order by b.no desc;

select b.no as 글번호, b.title as 제목, b.content as 내용, m.user_name||'('||b.user_id||')' as 글쓴이
from board b
join member m on b.user_id = m.user_id
where m.user_name like '%&&검색%'
or    b.content like '%&&검색%'
or    b.title like '%&&검색%'
order by b.no desc
;
undefine 검색;

insert into board(no, user_id, title, content)
values (brd_no_seq.nextval, 'jaeha', '내가 서태지보다 낫다', 'ㅇㄱㄹㅇ');

insert into board(no, user_id, title, content)
values (brd_no_seq.nextval, 'taiji', '다', '람쥐');

insert into board(no, user_id, title, content)
values(brd_no_seq.nextval, 'crom', '도', '배');


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
values (dept_deptno_seq.nextval, '운영부', '서울');
insert into dept(deptno, dname, loc)
values (dept_deptno_seq.nextval, '영업부', '부산');
insert into dept(deptno, dname, loc)
values (dept_deptno_seq.nextval, '개발부', '광주');

insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '신해철', '01011112222', 5000000, 10);
insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '유재하', '01011112223', 6000000, 20);
insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '서태지', '01011112224', 4000000, 30);
insert into emp(empno, ename, hp, salary, deptno) 
values(emp_empno_seq.nextval, '유희열', '01011112225', 3000000, 10);

select * from emp;
select * from dept;




select      e.empno as 사원번호, e.ename as 사원명, e.hp as 전화, replace(to_char(salary, '999999,999'), '0,000', '만') as 급여, d.dname as 부서, d.loc as 도시
from        emp e 
join        dept d on e.deptno=d.deptno;



-------------------------------------------------
----------------------11장------------------------
-------------------------------------------------
---n1/n1----

create view emp_test
as
select last_name,job_id, department_id from employees;

select * from emp_test;

create or replace view emp_test
as
select employee_id, last_name,job_id, department_id from employees;
--뷰가 잇으면 만들고 없으면 수정
--삭제는 drop

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
create synonym 사원 for employees;

select * from 사원;

commit;

