
select last_name �̸�, commission_pct Ŀ�̼�
from employees
where commission_pct is not null
order by commission_pct desc;

select last_name
from employees
where job_id like '__\%' escape '\';
--escape ���� Ư�������� ������ Ư������ ��ü�� ã��

select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

select last_name, department_id
from employees
where job_id = '&job_title';
-- ���ڿ��̸� ����ǥ �ݵ�� �ʿ�

select employee_id, last_name, job_id, &column_name
from employees
where &condition
order by &order_column ;
-- salary, salary > 15000, last_name

select employee_id, last_name, job_id, &&column_name
from employees
order by &column_name desc;
-- && ���� �ѹ��� ���

select employee_id, last_name, job_id, department_id
from employees;

define d = 200;
select employee_id, last_name, salary, department_id
from employees
where employee_id = &d;
undefine d;


---------------------------------------------------------------
---------------------------------------------------------------

--1
select LAST_NAME, SALARY
from employees
where salary > 12000;

--2
select last_name, department_id
from employees
where employee_id = 176;

--3
select LAST_NAME, SALARY
from employees
where salary < 5000 or salary > 12000;

--4
select last_name, job_id, hire_date
from employees
where last_name in ('Matos', 'Taylor')
order by hire_date;

--5
select LAST_NAME, DEPARTMENT_ID
from employees
where department_id in (20, 50)
order by LAST_NAME;

--6
select LAST_NAME "Employee", SALARY "Monthly Salary"
from employees
where (salary > 5000 and salary < 12000) and
department_id in (20, 50);

--7
select LAST_NAME, HIRE_DATE
from employees
where hire_date like '94%';

--8
select last_name, job_id
from employees
where manager_id is null;

--9
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by commission_pct desc;

--10
select last_name, salary
from employees
where salary > &salary;

--11
select employee_id, last_name, salary, department_id
from employees
where manager_id = &managerid
order by &order;

--12
select last_name
from employees
where last_name like '__a%'; 

--13
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

--14
select last_name, job_id, salary
from employees
where job_id in ('SA_REP', 'ST_CLERK') 
and salary not in (2500, 3500, 7000);

--15
select LAST_NAME "Employee", SALARY "Monthly Salary", commission_pct
from employees
where commission_pct = 0.2;


--chapter3--

select avg(salary) 
from employees
where salary > 10000;

select initcap(first_name), upper(last_name), lower(job_id) 
from employees;
--��ҹ��� ����

select last_name, salary, department_id
from employees
where last_name=initcap('king');
--�̹� �����Ͱ� initcap ���·� �ԷµǾ� �ֱ� ������ �̷��� �˻��ϴ°� ����

----- ���� ���� �Լ� -----
--concat = ||
--substr(x,n,m) = n���� m���� ���ڿ� ����
--length = ����
--instr(x,y) = y�� ���°����
--lpad(x,10,*) = 10������ *�� ���ʿ������� ä��
--rpad
--replace(x,y,z) = x���� y�� z�� �ٲ�
--trim(y from x) = x���� y�� �յڿ��� �߶�
--upper
--lower
--initcap

----- ���� ���� �Լ� -----
--round - �ݿø�
--trunc - ����
--mod(n,m) - n�� m���� ���� ������


select substr('hello world',6,2) from dual;
--6�������� 2��

select instr('hewllo world', 'w') from dual;

select last_name as �̸�, lpad(salary,10,'�١�') as �� from employees;
-- '~'�� ä��� RPAD�� �����ʺ���

select trim('h' from 'helloworldh') from dual;

select concat(first_name,  last_name) as �̸�, salary-mod(salary,1000) as ���� 
from employees;

select to_char(sysdate + 1/24/60, 'YYYY/MM/DD HH24:MI:SS') from dual;
-- 1/24�� 1�ð�, 1/24/60�� 1��, 1/24/60/60�� ��

select first_name || ' ' || last_name as �̸�, Trunc((sysdate-hire_date)/365) as �ټӳ��, replace(to_char(trunc(salary*12 + salary*nvl(commission_pct, 0), -4), '$999,999,999'), ',000', 'k') as ����
from employees
order by salary desc;
-- ����!!!!!

Select last_name as �̸�, to_char(hire_date, 'YYYY/MM/DD') as �����, trunc(sysdate-hire_date) as �ټ��ϼ�
from employees
order by �ټ��ϼ� desc;

select first_name || ' ' || last_name as �̸�, to_char(salary*12, '$999,999.00') as "����", to_char(salary*12 + salary*nvl(commission_pct, 0), '$999,999.00') as "����(Ŀ�̼�)", Trunc((sysdate-hire_date)/365) as �ټӳ�� 
from employees
order by ���� desc;


-----------------------------------------
-- NVL(x,y) null���� y�� ġȯ
-- NVL2(x,y,z) null�� �ƴϸ� y��, null�̸� z��
-- NULLIF(x,y) �ٸ��� x, ������ y
-- coalesce(a,b,c,d,...) null �ƴҶ� ����

SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG' , 1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP'  , 1.20*salary,
                                       salary) as "����"
 
FROM employees;



SELECT last_name,
      decode(mod(employee_id,2), 0, 'û��',
                                 1, '�鱺') as ��
from employees
order by ��;
-- decode �϶�

SELECT last_name,
      case mod(employee_id,2) when 0 then 'û��'
                              when 1 then '�鱺' 
                              end as ��
from employees
order by ��;
-- case �϶�

select first_name || ' ' || last_name as �̸�, to_char(salary*12 + salary*nvl(commission_pct, 0), '$999,999.00') as ����
from employees
order by ���� desc;


-------------
----scott----
-------------

select ename as �̸�, sal+nvl(comm,0) as ����,
       case when sal+nvl(comm,0) < 1000 then 'low' 
            when (sal+nvl(comm,0) > 1000 and sal+nvl(comm,0) < 2000) then 'middle' 
            when sal+nvl(comm,0) > 2000 then 'high' end as ��������
from emp
order by ���� desc;
--select end ������ else ~~ �ϸ� �������� ~~
-------------
-----n1------
-------------
update employees set salary = 10000 where employee_id=202;

select last_name||' '||first_name as �̸�, replace(to_char(trunc(salary*12, -3), '$999,999,999'), ',000', 'k') as ����,
       decode(trunc(salary-1,-4), 0,     'low', 
                                   10000, 'middle', 
                                          'high') as ��������
from employees
order by ���� desc;


--- ceil = �ø� �� ����� ����!

select last_name||' '||first_name as �̸�, replace(to_char(trunc(salary*12, -3), '$999,999,999'), ',000', 'k') as ����,
       case when salary <= 10000 then 'low' 
            when (salary > 10000 and salary < 20000) then 'middle' 
            else 'high' end as ��������
from employees
order by ���� desc;


-------------------
------�׷��Լ�------
-------------------

select nvl(to_char(department_id, 9999),'���߷�') as �μ���ȣ, count(*) as �ο�, trunc(avg(salary)) as "��� ����", max(salary)-min(salary) as "���� ����", variance(salary) as "���� �л�"
from employees
where department_id > 0
group by department_id
having count(*) > 1
order by "�μ���ȣ";
--�����Լ��� �ϳ��� ������ group by�� �������� �ݵ�� �־����
--�׷��� �����Ҷ� where �� �ƴ϶� having, �ݴ�� ���������� ������ ������
--������ �ٲ�� �� ��!
--���� ó���� from->where->group by->select->having->order by

select avg(commission_pct)
from employees;
--- null���� �ƿ� ������

select avg(nvl(commission_pct, 0))
from employees;
--- null���� 0���� ġȯ

select trunc(max(avg(salary)) - min(avg(salary)))
from employees
having count(*) > 1
group by department_id;

----------�η�2 p.195----------

--4
select max(salary) as "Maximum", min(salary) as "Minimum", sum(salary) as "Sum", avg(salary) as "Average"
from employees;

--5
select job_id,max(salary) as "Maximum", min(salary) as "Minimum", sum(salary) as "Sum", avg(salary) as "Average"
from employees
group by job_id;

--6
select job_id, count(*)
from employees
where job_id = '&job_name'
group by job_id;

--7
select count(distinct manager_id) as "Number of Managers"
from employees;

--8
select max(salary) - min(salary) as DIFFERENCE
from employees;

--9
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by min(salary) desc;

--10�١�
select count(*) as TOTAL, 
sum(decode(to_char(hire_date, 'YYYY'), 1995, 1, 0)) as "1995", 
sum(decode(to_char(hire_date, 'YYYY'), 1996, 1, 0)) as "1996",
sum(decode(to_char(hire_date, 'YYYY'), 1997, 1, 0)) as "1997",
sum(decode(to_char(hire_date, 'YYYY'), 1998, 1, 0)) as "1998"
from employees;

--11??
select job_id as job, 
sum(decode(department_id, 20, salary)) as "Dept 20",
sum(decode(department_id, 50, salary)) as "Dept 50",
sum(decode(department_id, 80, salary)) as "Dept 80",
sum(decode(department_id, 90, salary)) as "Dept 90",
sum(salary) as "Total"
from employees
group by job_id, department_id;

select department_id as job,
sum(decode(job_id, 'ST_MAN', salary)) as "ST_MAN",
sum(decode(job_id, 'ST_CLERK', salary)) as "ST_CLERK",
sum(decode(job_id, 'AD_PRES', salary)) as "AD_PRES",
sum(decode(job_id, 'AD_VP', salary)) as "AD_VP",
sum(salary) as "Total"
from employees
group by department_id;



--1
select last_name, salary, job_id
from employees
where job_id like '%MAN%' and salary >= 10000;

--2
select last_name, salary, job_id
from employees
where job_id like '%MAN%' or salary >= 10000;

--3
select last_name, salary, job_id
from employees
where job_id not in ('IT_PROG', 'ST_CLERK', 'SA_REP');

--4
select last_name, commission_pct
from employees
where commission_pct is not null;

--5
select last_name, salary, job_id
from employees
where job_id in ('ST_CLERK', 'SA_REP') and salary not in (2500,3500,7000);

--6
select department_id, max(salary)-min(salary)
from employees
group by department_id
order by department_id;

--7
select department_id, count(*)
from employees
group by department_id;

--8
select avg(nvl(commission_pct, 0))
from employees;

--9
select department_id, count(*)
from employees
where salary>5000
group by department_id;

--10
select department_id, job_id, sum(salary)
from employees
group by department_id, job_id;

--11
select job_id, sum(salary)
from employees
where job_id not like ('%REP%')
group by job_id
having sum(salary) > 13000
order by sum(salary);

-------------------------------------
-------------------------------------