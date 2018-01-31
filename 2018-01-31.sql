select last_name, salary
from employees
where salary > (select avg(salary)
                from employees);
                

select last_name, salary
from employees
where employee_id not in (select manager_id
                          from employees
                          where manager_id is not null);
                            
select 
       case when employee_id not in (select manager_id
                                     from employees
                                     where manager_id is not null) then '����' else '�ƴ�' end as ����,
       avg(salary)
from employees
group by case when employee_id not in (select manager_id
                                     from employees
                                     where manager_id is not null) then '����' else '�ƴ�' end
;

------ ���� ������ ��տ���, ������ �ƴ� ����� ��տ���



??

-- �λ�� �Ӹ����� ���� ��� ����?


--------------------8��--------------------
-------------------------------------------


create table set_a(a number(2));
create table set_b(b number(2));
insert into set_a values(1);
insert into set_a values(2);
insert into set_a values(3);
insert into set_a values(4);
insert into set_a values(5);
insert into set_a values(6);
insert into set_b values(4);
insert into set_b values(5);
insert into set_b values(6);
insert into set_b values(7);
insert into set_b values(8);
insert into set_b values(9);
commit;
select a,b from set_a full join set_b on a=b;

select b as ������ from set_b
union
select a from set_a;
select b as ������ from set_b
union all
select a from set_a;
-- union�� �ߺ��� �������� ����, union all�� ������
-- ���ٸ� ������ �ʿ����� �ʾ� union all�� �� ����(�ߺ����� �ʾҰų� ����� ���� ���)
select a as ������ from set_a
intersect
select b from set_b;

select a as ������ from set_a
minus
select b from set_b;


select first_name, last_name from employees where department_id=20
union all
select null, last_name from employees where department_id=50;

-----------------chapter.9 dml--------------
--------------------------------------------
insert into departments(department_id, department_name, manager_id, location_id)
values (70, 'Public Relations', 100, 1700);
-- �����͸� ��� ä���� ��� column �� ��������, �� �� ���� ����� (table�� ���´� �ٲ� �� �ۿ� ����)
select * from departments;


insert into departments(department_id, department_name)
values (30, 'Purchasing');

insert into departments
values (100, 'Finanace', NULL, NULL);

select * from departments;

INSERT INTO employees (employee_id,
first_name, last_name,
email, phone_number,
hire_date, job_id, salary,
commission_pct, manager_id,
department_id)
VALUES (113,
'Louis', 'Popp',
'LPOPP', '515.124.4567',
SYSDATE, 'AC_ACCOUNT', 6900,
NULL, 205, 110);

INSERT INTO employees
VALUES (114,
'Den', 'Raphealy',
'DRAPHEAL', '515.127.4561',
TO_DATE('1999/02/03', 'YYYY, MM, DD'),
'SA_REP', 11000, 0.2, 100, 60);

INSERT INTO departments
(department_id, department_name, location_id)
VALUES (&department_id, '&department_name',&location);

rollback;


--CTAS (Create Table As Select)
create table emp
as
select * from employees;

select * from emp;

drop table emp purge;

create table emp
as
select last_name as name, salary, department_id
from employees;


create table emp
as
select last_name as name, salary, department_id
from employees
where 1<>1;
--�����̺�

create table sales_reps
as
select employee_id as id, last_name as name, salary, commission_pct
from employees
where 1<>1;

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';
-- values ����ϸ� �� ��
select * from sales_reps;

UPDATE employees
SET department_id = 50
WHERE employee_id = 113;

create table copy_emp
as
select * from employees;

select * from copy_emp;

update copy_emp
set department_id = 110;

rollback;

----update----
UPDATE      copy_emp
SET         department_id = (SELECT department_id
                            FROM employees
                            WHERE employee_id = 100)
WHERE       job_id =        (SELECT job_id
                            FROM employees
                            WHERE employee_id = 200);

----delete from----                            
delete from departments
where       department_name = 'Finance';

delete from copy_emp;


DELETE FROM     employees
WHERE           department_id =
                                (SELECT department_id
                                FROM departments
                                WHERE department_name
                                LIKE '%Public%')
;

-------------Ʈ�����-------------
--Ʈ����� = �ּҾ�������(TX)
--���� ���� ����ȭó����� ��

--TX1
update employees set salary = salary * 1.1 where last_name = 'Vargas';
savepoint a;
update employees set salary=salary*1.5 where last_name = 'Vargas';
savepoint b;
update employees set salary=salary*0.5 where last_name = 'Vargas';
savepoint c;
rollback to b;
--- commit Ȥ�� rollback�� �� ��� �������� �� ������, �ѹ� to * �Ұ�� �� ���� �������� ������
rollback;



--------------------------------------------------
---------------chapter3 ��������------------------
--------------------------------------------------

--(1)
select sysdate from dual;

--(2),(3)
select  employee_id, last_name, salary, salary*1.155 as "New Salary"
from    employees;

--(4)
select  employee_id, last_name, salary, salary*1.155 as "New Salary", salary*1.155 - salary as "Increase"
from    employees;

--(5)
select  last_name, length(last_name)
from    employees
where   last_name like 'J%' 
OR      last_name like 'A%'
OR      last_name like 'M%'
order by 1;

select  last_name, length(last_name)
from    employees
where   last_name like '&First_letter%'
order by 1;

--(6)
select last_name, round(months_between(sysdate,hire_date))
from employees
order by 2;

--(7)
select last_name, lpad(salary, '15', '$')
from employees;

--(9)
select last_name, trunc((sysdate-hire_date)/7) as tenure
from employees
where department_id=90
order by tenure desc;




-------------------------------------------------------------------
-------------------------CHAPTER 10--------------------------------
-------------------------------------------------------------------
show user;

grant select on emp to n1;

select *
from scott.emp;

select *
from scott.emp
union
select employee_id, last_name, null, manager_id, hire_date, salary, commission_pct, department_id
from employees;

CREATE TABLE hire_dates
(id NUMBER(8),
hire_date DATE DEFAULT SYSDATE);

select * from hire_dates;

insert into hire_dates(id)
values(1);

select id, to_char(hire_date,'YYYY/MM/DD HH24:MI:SS') from hire_dates;

CREATE TABLE dept
(deptno NUMBER(2),
dname VARCHAR2(14),
loc VARCHAR2(13),
create_date DATE DEFAULT SYSDATE);
desc dept;d

