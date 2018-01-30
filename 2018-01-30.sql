
-------------------------------------------------------------***6단원***---------------------------------------------------------------
/* 조인에는 oracle조인과 ANSI조인이 있음. ppt에 있는건 ANSI조인. oracle조인은 ppt2(p.321)에 부록으로 있음. 둘이 혼용해 사용하면 안됨.

###1###. Oracle join과 ANSI join

1. Oracle JOIN
    1) Equi JOIN
    
    2) Outer JOIN
        - Left (outer) JOIN
        - Right (outer) JOIN
        - Full (outer) JOIN -> 지원x 
        
    3) Non Equi JOIN
    
    4) SELF JOIN
    
    5) cross join이 있긴함
    
2. ANSI JOIN
    1) JOIN ~ ON
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
        
    2) Natural JOIN
    
    3) JOIN ~ USING
    
    4) CROSS JOIN
*/



---- <<<Oracle JOIN>>>

------------------------ cross join(cartesian product)

/* 모든 경우의 수를 뽑아냄 -> 기존 데이터를 2배,3배로 늘릴 때 용이함.*/


-------------------------
-- conn scott/scott
-------------------------

select ename
from emp;       --1

select ename
from emp, dept;     --2

select ename, dname
from emp, dept;     --3

select ename, dname
from emp, dept
order by ename;     --4 : 1-4까지 해보면서 차이를 비교...!



-------------------------1) equi join(inner join)-----------------------------

/* 두 개 이상의 table에서 조건절에 들어가는 data 가 정확하게 일치할 때 사용 */

select ename, dname
from emp e, dept d
order by ename;

select ename, e.deptno, d.deptno, dname     --두번째 deptno는 deptno_1로 나옴 
from emp e, dept d
order by ename;

select e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno                   
order by ename;


------------------------
-- conn n1/n1
------------------------

--employees(사원)테이블과 departments(부서)테이블을 조인해서 사원명과 부서명을 출력.
select last_name, department_name
from employees e, departments d
where e.department_id = d.department_id;

select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;    -- 19줄밖에 안나옴...부서id가 null값인 한명이 있기때문!





------------------------------2) outer join----------------------------------

/* 두 개 이상의 table에서 어느 한쪽의 data가 없는 row도 가져오게 된다.
   LEFT : 왼쪽 table은 모두 가져온다.
   RIGHT : 오른쪽 table은 모두 가져온다.*/
   

-------------------------
-- conn scott/scott
-------------------------

update emp set deptno = null where ename = 'JONES'; 
commit;                   -- JONES를 대기발령으로 바꿔버림. 따라서, 밑에 결과 11개뿐

select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno                   
order by ename;     --11개뿐. JONES 안나옴


-- left outer join
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)   -- 조인할때는 from에 적은 테이블의 순서대로 놓는것이 좋음.                
order by ename;                -- 소속 부서가 없는 사원명도 가져옴


-- right outer join
select e.ename, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno   -- 이 경우는 소속된 사원이 없는 부서명도 가져옴          
order by ename;


-- full outer join  -> 하지만 이렇게 쓸 수 없음. oracle join에서는 지원 안함.
select e.ename, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno(+)   -- 위에 경우 둘다 가져옴.               
order by ename;


------------------------
-- conn n1/n1
------------------------

-- employees(사원)테이블과 departments(부서)테이블을 조인해서 사원명과 부서명을 출력.
--(1) 부서가 없는 사원도 출력 (left join)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--(2) 사원이 없는 부서도 출력 (right join)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;





---------------------------------3)non equi join--------------------------------

/*
두 개의 테이블 간에 칼럼 값들이 서로 정확하게 일치하지 않는 경우에 사용된다.
"=" 등가 연산자가 아닌 다른(Between , > , >= ,< , <= ,<> 등)  연산자들을 사용하여 Join 을 수행한다.*/

-------------------------
-- conn scott/scott
-------------------------

select e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal; -- = (where s.losal <= e.sal and e.sal <= s.hisal;)


-------------------------
-- conn n1/n1
-------------------------

-- employees(사원)테이블과 job_grades 테이블을 조인해서 사원명과 급여, 급여등급을 출력.
select e.last_name as 사원명, e.salary as 급여, j.grade_level as 급여등급
from employees e, job_grades j
where e.salary between j.lowest_sal and j.highest_sal;





-------------------------------4) self join--------------------------------

/*자기 테이블 안에서 join해야 할 경우에 쓴다.
  그리고 self join에서는 테이블의 alias가 필수!! (앞에 join에서는 옵션이였음...하지만 해주는 것이 편함)*/
  
-------------------------
-- conn scott/scott
-------------------------
select e.ename as 사원, m.ename as 직속상사
from emp e, emp m      -- alias 필수!!
where e.mgr = m.empno; -- e 테이블의 manager번호는 m 테이블의 사원번호이니깐! key값이 뭔지 아는 것이 중요!

-- 직속상사가 없는 KING도 나오게하려면?
select e.ename as 사원, m.ename as 직속상사
from emp e, emp m      
where e.mgr = m.empno(+);   -- left outer join 사용!



-------------------------
-- conn n1/n1
-------------------------

-- employees(사원)테이블을 이용해서, 사원명과 사수명을 출력.
select e.last_name, m.last_name
from employees e, employees m       -- alias 필수!!
where e.manager_id = m.employee_id;

select e.last_name as 사원, m.last_name as 사수
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by m.last_name;






---- <<<ANSI JOIN>>>

/* Oracle join을 ANSI join으로 써보자...! */

---------------------------1) JOIN ~ ON -----------------------------------------

-------- equi join(inner join)

/* Oracle join의 FROM에서 2개이상 테이블 적을때 ,대신 INNER JOIN을 쓰고,  where 대신 ON 으로!*/

-------------------------
-- conn scott/scott
-------------------------

select e.ename, e.deptno, d.deptno, d.dname
from emp e INNER JOIN dept d
ON e.deptno = d.deptno                   
order by ename;


------------------------
-- conn n1/n1
------------------------

--employees(사원)테이블과 departments(부서)테이블을 조인해서 사원명과 부서명을 출력.
select last_name, department_name
from employees e JOIN departments d     --그냥 JOIN만 해도 되긴함
ON e.department_id = d.department_id;

select e.last_name, d.department_id, d.department_name
from employees e INNER JOIN departments d
ON e.department_id = d.department_id;   



-------- outer join

/* Oracle join과 다르게 (+)를 붙이지 않고 아예 명시적으로(LEFT, RIGHT, FULL) 써버림.*/
   

-------------------------
-- conn scott/scott
-------------------------

select e.ename, d.dname
from emp e INNER JOIN dept d
ON e.deptno = d.deptno                   
order by ename;     --11개뿐. JONES 안나옴


-- left join
select e.ename, d.dname
from emp e LEFT JOIN dept d
ON e.deptno = d.deptno   
order by ename;           -- 소속 부서가 없는 사원명도 가져옴


-- right join 
select e.ename, d.dname
from emp e RIGHT JOIN dept d
ON e.deptno = d.deptno   -- 이 경우는 소속된 사원이 없는 부서명도 가져옴          
order by ename;


-- full join  -> ANSI join에서는 지원 함.
select e.ename, d.dname
from emp e FULL JOIN dept d
ON e.deptno = d.deptno   -- 위에 경우 둘다 가져옴.              
order by ename;



------------------------
-- conn n1/n1
------------------------

-- employees(사원)테이블과 departments(부서)테이블을 조인해서 사원명과 부서명을 출력.
--(1) 부서가 없는 사원도 출력 (left join)
select e.last_name, d.department_name
from employees e LEFT JOIN departments d
ON e.department_id = d.department_id;

--(2) 사원이 없는 부서도 출력 (right join)
select e.last_name, d.department_name
from employees e RIGHT JOIN departments d
ON e.department_id = d.department_id;

--(3) 부서가 없는 사원, 사원이 없는 부서 둘다 출력 (FULL join)
select e.last_name, d.department_name
from employees e FULL JOIN departments d
ON e.department_id = d.department_id;



-------- non equi join

-------------------------
-- conn scott/scott
-------------------------

select e.ename, e.sal, s.grade
from emp e INNER JOIN salgrade s    --명시적으로 INNER 표시해주는 것이 좋음.
ON e.sal between s.losal and s.hisal; -- =(where s.losal <= e.sal and e.sal <= s.hisal;) 


-------------------------
-- conn n1/n1
-------------------------

-- employees(사원)테이블과 job_grades 테이블을 조인해서 사원명과 급여, 급여등급을 출력.
select e.last_name as 사원명, e.salary as 급여, j.grade_level as 급여등급
from employees e INNER JOIN job_grades j
ON e.salary between j.lowest_sal and j.highest_sal;



-------- self join

/*자기 테이블 안에서 join해야 할 경우에 쓴다.
  self join에서는 테이블의 alias가 필수!! (앞에 join에서는 옵션이였음...)*/
  
-------------------------
-- conn scott/scott
-------------------------
select e.ename as 사원, m.ename as 직속상사
from emp e INNER JOIN emp m      -- alias 필수!!
ON e.mgr = m.empno; -- e 테이블의 manager번호는 m 테이블의 사원번호이니깐! key값이 뭔지 아는 것이 중요!

-- 직속상사가 없는 KING도 나오게하려면?
select e.ename as 사원, m.ename as 직속상사
from emp e LEFT JOIN emp m      
ON e.mgr = m.empno(+);   -- left outer join 사용!



-------------------------
-- conn n1/n1
-------------------------

-- employees(사원)테이블을 이용해서, 사원명과 사수명을 출력.
select e.last_name, m.last_name
from employees e INNER JOIN employees m       -- alias 필수!!
ON e.manager_id = m.employee_id;

select e.last_name as 사원, m.last_name as 사수
from employees e LEFT JOIN employees m
ON e.manager_id = m.employee_id
order by m.last_name;



---------------------------2) Natural JOIN------------------------------------

-------------------------
-- conn scott/scott
-------------------------

select ename, dname
from emp natural join dept; --emp 테이블의 deptno 컬럼과 dept 테이블의 deptno 컬럼이 동일하므로 잘 나옴.



-------------------------
-- conn n1/n1
-------------------------

select last_name, department_name
from employees natural join departments; /* department_id 뿐만아니라 
사원 테이블의 manager_id 컬럼과 부서 테이블의 manager_id도 join 조건을 자동으로 설정하게 되는데, 
사원테이블에서는 사수를 의미하고 부서테이블에서는 부서장을 뜻하기 때문에 잘못된 결과가 나오는 것*/




---------------------------3) JOIN ~ USING()------------------------------------

/*위에 자동으로 join 조건이 설정되는 Natural join은 문제가 있으므로, 
"using ()"을 써서 명시적으로 어떤 컬럼으로 join할지 씀 */

-------------------------
-- conn scott/scott
-------------------------

select ename, dname
from emp left join dept
using (deptno);


-------------------------
-- conn n1/n1
-------------------------

select last_name, department_name
from employees join departments
using (department_id);

select last_name, department_name
from employees left join departments
using (department_id);



---------------------------4) cross join---------------------------------
/*
Oracle JOIN과 달리 명시적으로 표현해 일부러 cartesian product를 하려고한다는 것을 명확하게 알 수 있음.
모든 경우의 수를 뽑아냄 -> 기존 데이터를 2배,3배로 늘릴 때 용이함
*/

-------------------------
-- conn scott/scott
-------------------------

select  ename, dname
from    emp cross join dept;    







/*
###2###. Threeways JOIN
*/


--Threeways JOIN(Oracle join으로...)

-------------------------
-- conn scott/scott
-------------------------

select  e.ename, d.dname
from    emp e, dept d
where   e.deptno = d.deptno(+);   --1단계. 이걸 하나의 테이블(집합)이라고 생각하자


select e.ename, d.dname, s.grade
from   emp e, dept d, salgrade s
where  e.deptno = d.deptno(+)
and    e.sal between s.losal and s.hisal;   --2단계. 이렇게 두단계에 걸쳐 join하기! 항상 하나하나씩...한번에 하려하지말고


-------------------------
-- conn n1/n1
-------------------------

select  e.last_name as 사원명, d.department_name as 부서명, j.grade_level as 등급
from    employees e, departments d, job_grades j
where   e.department_id = d.department_id(+)
and     e.salary between j.lowest_sal and j.highest_sal;



--Threeways JOIN(ANSI join으로...)

-------------------------
-- conn scott/scott
-------------------------

select e.ename, d.dname
from   emp e LEFT JOIN dept d
ON     e.deptno = d.deptno;         --1단계. 이걸 하나의 테이블(집합)이라고 생각하자

select e.ename, d.dname, s.grade
from   emp e LEFT JOIN dept d
ON     e.deptno = d.deptno
JOIN   salgrade s
ON     e.sal between s.losal and s.hisal;   --2단계. 이렇게 두단계에 걸쳐 join하기!


-------------------------
-- conn n1/n1
-------------------------

select  e.last_name as 사원명, d.department_name as 부서명, j.grade_level as 등급
from    employees e left join departments d
on      e.department_id = d.department_id
join    job_grades j
on      e.salary between j.lowest_sal and j.highest_sal;




--ANSI join으로 연습

select  e.last_name as 사원명
        ,d.department_name as 부서명
from    employees e left join departments d
on      e. department_id = d.department_id      --1단계. 부서id로 left join하기. 20줄 잘 나옴.



select  e.last_name as 사원명
        ,d.department_name as 부서명
        ,l.city as 도시명
from    employees e left join departments d
on      e. department_id = d.department_id
join    locations l
on      d.location_id = l.location_id;          --2단계. locations테이블 join하기 but, 이렇게 하면 전단계에서 20줄이였어도 19줄밖에 안나오게 됨




select  e.last_name as 사원명
        ,d.department_name as 부서명
        ,l.city as 도시명
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id;          --3단계. left join하기. 20줄 잘 나옴.



select  e.last_name as 사원명
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
join    countries c
on      l.country_id = c.country_id;        --4단계. countries테이블 join하기. but, 이러면 또 19줄...




select  e.last_name as 사원명
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c                     --5단계. left join하기. 20줄 잘 나옴.
on      l.country_id = c.country_id;           




select  e.last_name as 사원명
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
        ,r.region_name as 지역명
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
join    regions r                           --6단계. regions테이블 join하기. but, 이러면 또 19줄...
on      c.region_id = r.region_id;



select  e.last_name as 사원명
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
        ,r.region_name as 지역명
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
left join    regions r                      --7단계. left join하기. 20줄 잘 나옴.
on      c.region_id = r.region_id;



select  e.last_name as 사원명
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
        ,r.region_name as 지역명
        ,e.salary as 급여
        ,j.GRADE_LEVEL as 등급
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
left join    regions r
on      c.region_id = r.region_id
join    job_grades j
on      j.lowest_sal <= e.salary and e.salary <= j.highest_sal;     --8단계. job_grades테이블 join하기이때는 20줄 잘나옴...이렇게 left join 안 할 수 있으니깐 조인 하나씩 하면서 확인!!



select  e.last_name as 사원명
        ,m.last_name as 사수
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
        ,r.region_name as 지역명
        ,e.salary as 급여
        ,j.GRADE_LEVEL as 등급
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
left join    regions r
on      c.region_id = r.region_id
join    job_grades j
on      j.lowest_sal <= e.salary and e.salary <= j.highest_sal
join    employees m                                             --9단계. employees 테이블 self join하기. 이러면 사수없는 한명때문에 19줄 나옴
on      e.manager_id = m.employee_id; 



select  e.last_name as 사원명
        ,m.last_name as 사수
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
        ,r.region_name as 지역명
        ,e.salary as 급여
        ,j.GRADE_LEVEL as 등급
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
left join    regions r
on      c.region_id = r.region_id
join    job_grades j
on      j.lowest_sal <= e.salary and e.salary <= j.highest_sal
left join    employees m                                             --10단계. left join하기. 20줄 잘 나옴.
on      e.manager_id = m.employee_id; 



select  e.last_name as 사원명
        ,m.last_name as 사수
        ,j2.job_title as 업무명
        ,d.department_name as 부서명
        ,l.city as 도시명
        ,C.COUNTRY_NAME as 나라명
        ,r.region_name as 지역명
        ,e.salary as 급여
        ,j.GRADE_LEVEL as 등급
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
left join    regions r
on      c.region_id = r.region_id
join    job_grades j
on      j.lowest_sal <= e.salary and e.salary <= j.highest_sal
left join    employees m                                            
on      e.manager_id = m.employee_id
join    jobs j2                                                 --11단계. jobs테이블 join하기. 이때는 20줄 잘나옴.
on      e.job_id = j2.job_id;





-------------------------------------------------------
--수행평가_jOIN (oracle)



select      e.last_name as 사원이름, e.salary as 급여, grade_level as 사원등급, department_name as 부서이름, city as 도시, country_name as 나라, region_name as 지역, e1.last_name as 사수
from        employees e, job_grades g, departments d, locations l, countries c, regions r, employees e1
where       e.salary between g.lowest_sal and g.highest_sal
and         e.department_id = d.department_id(+)
and         d.location_id = l.location_id(+)
and         l.country_id = c.country_id(+)
and         c.region_id = r.region_id(+)
and         e.manager_id = e1.employee_id(+)
;

select      e.last_name as 사원이름, e.salary as 급여, g.grade_level as 사원등급, d.department_name as 부서이름, l.city as 도시, c.country_name as 나라, r.region_name as 지역, e1.last_name as 사수
from        employees e
join        job_grades g
on          e.salary between g.lowest_sal and g.highest_sal
left join   departments d
on          e.department_id = d.department_id
left join   locations l
on          d.location_id = l.location_id
left join   countries c
on          l.country_id = c.country_id
left join   regions r
on          c.region_id = r.region_id
left join   employees e1
on          e.manager_id = e1.employee_id
;




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
-- inline view 
-- view = 쿼리를 저장하고 있는 객체

select nvl(department_id,999) as department_id, job_id, sum(salary) as sum_sal
from employees
group by department_id, job_id
order by 1,2;

select rownum as rnum from employees where rownum <=3;



-----------------------------------------------------
------------------chapter 7--------------------------
-----------------------------------------------------
-------subquery

select  last_name, salary
from    employees
where   salary >    (select salary
                     from   employees
                     where  last_name = 'Abel')
;

select department_id, min(salary)
from employees
group by department_id
having min(salary) >
                    (select min(salary)
                     from employees
                     where department_id = 50)
;

select  last_name, salary, department_id
from    employees
where   salary in (select min(salary)
                   from employees
                   group by department_id)
order by 2
;
--부서별로 급여가 가장 많은 인원과 같은 급여를 받는 인원들

select employee_id, last_name, job_id, salary
from employees
where salary < any
                  (select salary
                   from employees
                   where job_id = 'IT_PROG')
AND job_id <> 'IT_PROG'
;
-- any는 저 중에 하나만 해당되도 됨, all은 다 해당되야함

select * from departments
where not exists
                (select * from employees
                 where employees.department_id=departments.department_id)
;
-- 상호참조 하고 있는 쿼리, 성능을 낮춘다

select e.last_name
from employees e
where e.employee_id not in
                          (select e1.manager_id
                           from employees e1
                           where e1.manager_id is not null);