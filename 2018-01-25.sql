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

--select, from, where, group, having, order by : 오라클에서의 일반적인 절

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

-- null이 포함된 수식은 제대로 출력되지 않는다

select last_name
            ,salary
            ,salary*12 + salary*12*nvl(commission_pct,0)
from   employees;
-- 단 nvl을 많이 사용하는건 별로 좋지 않음, 설계가 잘못된 것
-- null의 사용도 최대한 줄일 것, 확실히 값이 없을 경우 0값을 넣어야 함

select last_name as "Last Name"
            ,commission_pct  comm
from    employees;
-- 기본적으로는 대문자, 하지만 따옴표를 넣으면 공백까지 그대로 나옴.
-- as는 안 써도 됨

select last_name || '사원의 급여는' || salary || '입니다' as 봉급
from employees;

select 'select * from' || tname || ':' from tab;
-- 응용 : cmd에서 모든 테이블을 파악하기 위해 만든 명령문

select department_name || q'[Department's Manager id: ]'
            || manager_id
as "Department  id"
from departments;

-- q'[~~]' 를 통해 특수문자(따옴표 등)을 입력

select distinct department_id
from                  employees;

-- distinct = 중복 제거

desc employees;

-- 테이블의 구조 (describe = desc)

select sysdate from dual;
-- dual은 데이터가 하나만 들어있는 공용 계정 (누구나 접근 가능)

select sysdate - to_date('2013-12-23', 'YYYY-MM-DD') from dual;

select employee_id, last_name, job_id, department_id
from employees
where department_id = 90;

select last_name, job_id, department_id
from employees
where last_name = 'Whalen';
--대소문자 구분해야함

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

-- 위 2 쿼리는 일치함

select last_name
from employees
where last_name like '__r%' ;
-- _는 글자수까지, %는 글자수 무관(없어도됨)

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

-- order by의 이용

select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

-- 치환변수 - 실행할때마다 바뀜 &~

