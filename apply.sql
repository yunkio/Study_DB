select rnum,
       decode(rnum, 1, department_id, 2, department_id) as 부서,
       decode(rnum,1,job_id) as 업무
      ,sum(sum_sal) as 합계
from (select nvl(department_id,999) as department_id, job_id, sum(salary) as sum_sal
      from employees
      group by department_id, job_id) 
      cross join
     (select rownum as rnum from employees where rownum <=3)
group by rnum, decode(rnum, 1, department_id, 2, department_id), decode(rnum,1,job_id)
order by 2,3;


select job_id,
       sum(decode(department_id,10,1,0)) as d10,
       sum(decode(department_id,20,1,0)) as d20,
       sum(decode(department_id,50,1,0)) as d50,
       sum(decode(department_id,60,1,0)) as d60,
       sum(decode(department_id,80,1,0)) as d80,
       sum(decode(department_id,90,1,0)) as d90,
       sum(decode(department_id,110,1,0)) as d110,
       sum(decode(nvl(department_id,999),999,1,0)) as None,
       sum(1) as 합계,
       trunc(avg(salary))
from employees
group by job_id;


------ 막내 끼리의 평균연봉, 막내가 아닌 놈들의 평균연봉 ------
select 
         case when employee_id not in (select manager_id
                                       from employees
                                       where manager_id is not null) then '맞음' else '아님' end as 막내,
         avg(salary)
from     employees
group by case when employee_id not in (select manager_id
                                       from employees
                                       where manager_id is not null) then '맞음' else '아님' end
;


--- 부사수 머릿수에 따른 평균 연봉 ---

;


select m.last_name, count(m.last_name) as mentee, avg(m.salary) as avgsal
from employees e
left join employees m on e.manager_id = m.employee_id
group by m.last_name;


select mentee as 부사수, round(avg(avgsal)) as 평균
from (select m.last_name, count(m.last_name) as mentee, avg(m.salary) as avgsal
     from employees e
     left join employees m on e.manager_id = m.employee_id
     group by m.last_name)
group by mentee
order by 1;

-- 부사수 0명인 애들 어떻게 해야하지?


--- 부서이름, 부서별 평균 재직 일수, 부서별 평균 연봉 ---