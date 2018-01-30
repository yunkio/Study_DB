-------------
-- conn n1/n1
-------------
select *
from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

select location_id
            ,department_id
from   departments;

--select, from, where, group, having, order by : ����Ŭ������ �Ϲ����� ��

select last_name
            ,salary
            ,salary * 12
from   employees;

select last_name
           ,salary
           ,salary*12 - salary*6
from   employees;

select last_name
            ,salary
            ,salary*12 + salary*12*commission_pct
from   employees;

-- null�� ���Ե� ������ ����� ��µ��� �ʴ´�

select last_name
            ,salary
            ,salary*12 + salary*12*nvl(commission_pct,0)
from   employees;
-- �� nvl�� ���� ����ϴ°� ���� ���� ����, ���谡 �߸��� ��
-- null�� ��뵵 �ִ��� ���� ��, Ȯ���� ���� ���� ��� 0���� �־�� ��

select last_name as "Last Name"
            ,commission_pct  comm
from    employees;
-- �⺻�����δ� �빮��, ������ ����ǥ�� ������ ������� �״�� ����.
-- as�� �� �ᵵ ��

select last_name || '����� �޿���' || salary || '�Դϴ�' as ����
from employees;

select 'select * from' || tname || ':' from tab;
-- ���� : cmd���� ��� ���̺��� �ľ��ϱ� ���� ���� ��ɹ�

select department_name || q'[Department's Manager id: ]'
            || manager_id
as "Department  id"
from departments;

-- q'[~~]' �� ���� Ư������(����ǥ ��)�� �Է�

select distinct department_id
from                  employees;

-- distinct = �ߺ� ����

desc employees;

-- ���̺��� ���� (describe = desc)

select sysdate from dual;
-- dual�� �����Ͱ� �ϳ��� ����ִ� ���� ���� (������ ���� ����)

select sysdate - to_date('2013-12-23', 'YYYY-MM-DD') from dual;

select employee_id, last_name, job_id, department_id
from employees
where department_id = 90;

select last_name, job_id, department_id
from employees
where last_name = 'Whalen';
--��ҹ��� �����ؾ���

select last_name, job_id, salary*12, hire_date
from employees
where hire_date <= '96/02/17';

select last_name, salary
from employees
where salary between 2500 and 3000 ;



select employee_id, last_name, salary, manager_id
from employees
where manager_id IN (100, 101, 201);

select employee_id, last_name, salary, manager_id
from employees
where manager_id = 100
or        manager_id = 101
or        manager_id = 201;

-- �� 2 ������ ��ġ��

select last_name
from employees
where last_name like '__r%' ;
-- _�� ���ڼ�����, %�� ���ڼ� ����(�����)

select last_name, manager_id
from employees
where manager_id is null;

select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
and job_id like '%MAN%' ;


select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
OR job_id like '%MAN%' ;

SELECT LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE job_id not in ('IT_PROG', 'ST_CLERK', 'SA_REP');

select last_name, job_id, department_id, hire_date
from employees
order by hire_date desc;

select employee_id, last_name, salary*12 + salary*12*nvl(commission_pct,0) as salary
from employees
order by salary desc;

select last_name, job_id, department_id, employee_id
from employees
order by 3 desc, 4;

-- order by�� �̿�

select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

-- ġȯ���� - �����Ҷ����� �ٲ� &~

