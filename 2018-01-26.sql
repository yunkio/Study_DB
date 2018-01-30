
select last_name 이름, commission_pct 커미션
from employees
where commission_pct is not null
order by commission_pct desc;

select last_name
from employees
where job_id like '__\%' escape '\';
--escape 다음 특수문제에 들어오는 특수문자 자체를 찾음

select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

select last_name, department_id
from employees
where job_id = '&job_title';
-- 문자열이면 따옴표 반드시 필요

select employee_id, last_name, job_id, &column_name
from employees
where &condition
order by &order_column ;
-- salary, salary > 15000, last_name

select employee_id, last_name, job_id, &&column_name
from employees
order by &column_name desc;
-- && 쓰면 한번만 물어봄

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
--대소문자 변경

select last_name, salary, department_id
from employees
where last_name=initcap('king');
--이미 데이터가 initcap 상태로 입력되어 있기 때문에 이렇게 검색하는게 조음

----- 문자 조작 함수 -----
--concat = ||
--substr(x,n,m) = n부터 m개의 문자열 추출
--length = 길이
--instr(x,y) = y가 몇번째인지
--lpad(x,10,*) = 10개까지 *를 왼쪽에서부터 채움
--rpad
--replace(x,y,z) = x에서 y를 z로 바꿈
--trim(y from x) = x에서 y를 앞뒤에서 잘라냄
--upper
--lower
--initcap

----- 숫자 변경 함수 -----
--round - 반올림
--trunc - 버림
--mod(n,m) - n을 m으로 나눈 나머지


select substr('hello world',6,2) from dual;
--6에서부터 2개

select instr('hewllo world', 'w') from dual;

select last_name as 이름, lpad(salary,10,'☆★') as 돈 from employees;
-- '~'로 채우기 RPAD는 오른쪽부터

select trim('h' from 'helloworldh') from dual;

select concat(first_name,  last_name) as 이름, salary-mod(salary,1000) as 월급 
from employees;

select to_char(sysdate + 1/24/60, 'YYYY/MM/DD HH24:MI:SS') from dual;
-- 1/24는 1시간, 1/24/60은 1분, 1/24/60/60은 초

select first_name || ' ' || last_name as 이름, Trunc((sysdate-hire_date)/365) as 근속년수, replace(to_char(trunc(salary*12 + salary*nvl(commission_pct, 0), -4), '$999,999,999'), ',000', 'k') as 연봉
from employees
order by salary desc;
-- 성공!!!!!

Select last_name as 이름, to_char(hire_date, 'YYYY/MM/DD') as 고용일, trunc(sysdate-hire_date) as 근속일수
from employees
order by 근속일수 desc;

select first_name || ' ' || last_name as 이름, to_char(salary*12, '$999,999.00') as "봉급", to_char(salary*12 + salary*nvl(commission_pct, 0), '$999,999.00') as "봉급(커미션)", Trunc((sysdate-hire_date)/365) as 근속년수 
from employees
order by 봉급 desc;


-----------------------------------------
-- NVL(x,y) null값을 y로 치환
-- NVL2(x,y,z) null이 아니면 y로, null이면 z로
-- NULLIF(x,y) 다르면 x, 같으면 y
-- coalesce(a,b,c,d,...) null 아닐때 멈춤

SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG' , 1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP'  , 1.20*salary,
                                       salary) as "봉급"
 
FROM employees;



SELECT last_name,
      decode(mod(employee_id,2), 0, '청군',
                                 1, '백군') as 팀
from employees
order by 팀;
-- decode 일때

SELECT last_name,
      case mod(employee_id,2) when 0 then '청군'
                              when 1 then '백군' 
                              end as 팀
from employees
order by 팀;
-- case 일때

select first_name || ' ' || last_name as 이름, to_char(salary*12 + salary*nvl(commission_pct, 0), '$999,999.00') as 연봉
from employees
order by 연봉 desc;


-------------
----scott----
-------------

select ename as 이름, sal+nvl(comm,0) as 연봉,
       case when sal+nvl(comm,0) < 1000 then 'low' 
            when (sal+nvl(comm,0) > 1000 and sal+nvl(comm,0) < 2000) then 'middle' 
            when sal+nvl(comm,0) > 2000 then 'high' end as 연봉수준
from emp
order by 연봉 desc;
--select end 직전에 else ~~ 하면 나머지는 ~~
-------------
-----n1------
-------------
update employees set salary = 10000 where employee_id=202;

select last_name||' '||first_name as 이름, replace(to_char(trunc(salary*12, -3), '$999,999,999'), ',000', 'k') as 연봉,
       decode(trunc(salary-1,-4), 0,     'low', 
                                   10000, 'middle', 
                                          'high') as 연봉수준
from employees
order by 연봉 desc;


--- ceil = 올림 이 방법도 가능!

select last_name||' '||first_name as 이름, replace(to_char(trunc(salary*12, -3), '$999,999,999'), ',000', 'k') as 연봉,
       case when salary <= 10000 then 'low' 
            when (salary > 10000 and salary < 20000) then 'middle' 
            else 'high' end as 연봉수준
from employees
order by 연봉 desc;


-------------------
------그룹함수------
-------------------

select nvl(to_char(department_id, 9999),'대기발령') as 부서번호, count(*) as 인원, trunc(avg(salary)) as "평균 봉급", max(salary)-min(salary) as "봉급 격차", variance(salary) as "봉급 분산"
from employees
where department_id > 0
group by department_id
having count(*) > 1
order by "부서번호";
--집계함수를 하나라도 썼을시 group by에 나머지를 반드시 넣어야함
--그룹을 제한할땐 where 이 아니라 having, 반대는 가능하지만 성능이 떨어짐
--순서가 바뀌면 안 됨!
--내부 처리는 from->where->group by->select->having->order by

select avg(commission_pct)
from employees;
--- null값을 아예 제외함

select avg(nvl(commission_pct, 0))
from employees;
--- null값을 0으로 치환

select trunc(max(avg(salary)) - min(avg(salary)))
from employees
having count(*) > 1
group by department_id;

----------부록2 p.195----------

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

--10☆★
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