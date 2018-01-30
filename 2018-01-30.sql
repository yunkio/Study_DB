
-------------------------------------------------------------***6�ܿ�***---------------------------------------------------------------
/* ���ο��� oracle���ΰ� ANSI������ ����. ppt�� �ִ°� ANSI����. oracle������ ppt2(p.321)�� �η����� ����. ���� ȥ���� ����ϸ� �ȵ�.

###1###. Oracle join�� ANSI join

1. Oracle JOIN
    1) Equi JOIN
    
    2) Outer JOIN
        - Left (outer) JOIN
        - Right (outer) JOIN
        - Full (outer) JOIN -> ����x 
        
    3) Non Equi JOIN
    
    4) SELF JOIN
    
    5) cross join�� �ֱ���
    
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

/* ��� ����� ���� �̾Ƴ� -> ���� �����͸� 2��,3��� �ø� �� ������.*/


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
order by ename;     --4 : 1-4���� �غ��鼭 ���̸� ��...!



-------------------------1) equi join(inner join)-----------------------------

/* �� �� �̻��� table���� �������� ���� data �� ��Ȯ�ϰ� ��ġ�� �� ��� */

select ename, dname
from emp e, dept d
order by ename;

select ename, e.deptno, d.deptno, dname     --�ι�° deptno�� deptno_1�� ���� 
from emp e, dept d
order by ename;

select e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno                   
order by ename;


------------------------
-- conn n1/n1
------------------------

--employees(���)���̺�� departments(�μ�)���̺��� �����ؼ� ������ �μ����� ���.
select last_name, department_name
from employees e, departments d
where e.department_id = d.department_id;

select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;    -- 19�ٹۿ� �ȳ���...�μ�id�� null���� �Ѹ��� �ֱ⶧��!





------------------------------2) outer join----------------------------------

/* �� �� �̻��� table���� ��� ������ data�� ���� row�� �������� �ȴ�.
   LEFT : ���� table�� ��� �����´�.
   RIGHT : ������ table�� ��� �����´�.*/
   

-------------------------
-- conn scott/scott
-------------------------

update emp set deptno = null where ename = 'JONES'; 
commit;                   -- JONES�� ���߷����� �ٲ����. ����, �ؿ� ��� 11����

select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno                   
order by ename;     --11����. JONES �ȳ���


-- left outer join
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)   -- �����Ҷ��� from�� ���� ���̺��� ������� ���°��� ����.                
order by ename;                -- �Ҽ� �μ��� ���� ����� ������


-- right outer join
select e.ename, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno   -- �� ���� �Ҽӵ� ����� ���� �μ��� ������          
order by ename;


-- full outer join  -> ������ �̷��� �� �� ����. oracle join������ ���� ����.
select e.ename, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno(+)   -- ���� ��� �Ѵ� ������.               
order by ename;


------------------------
-- conn n1/n1
------------------------

-- employees(���)���̺�� departments(�μ�)���̺��� �����ؼ� ������ �μ����� ���.
--(1) �μ��� ���� ����� ��� (left join)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--(2) ����� ���� �μ��� ��� (right join)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;





---------------------------------3)non equi join--------------------------------

/*
�� ���� ���̺� ���� Į�� ������ ���� ��Ȯ�ϰ� ��ġ���� �ʴ� ��쿡 ���ȴ�.
"=" � �����ڰ� �ƴ� �ٸ�(Between , > , >= ,< , <= ,<> ��)  �����ڵ��� ����Ͽ� Join �� �����Ѵ�.*/

-------------------------
-- conn scott/scott
-------------------------

select e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal; -- = (where s.losal <= e.sal and e.sal <= s.hisal;)


-------------------------
-- conn n1/n1
-------------------------

-- employees(���)���̺�� job_grades ���̺��� �����ؼ� ������ �޿�, �޿������ ���.
select e.last_name as �����, e.salary as �޿�, j.grade_level as �޿����
from employees e, job_grades j
where e.salary between j.lowest_sal and j.highest_sal;





-------------------------------4) self join--------------------------------

/*�ڱ� ���̺� �ȿ��� join�ؾ� �� ��쿡 ����.
  �׸��� self join������ ���̺��� alias�� �ʼ�!! (�տ� join������ �ɼ��̿���...������ ���ִ� ���� ����)*/
  
-------------------------
-- conn scott/scott
-------------------------
select e.ename as ���, m.ename as ���ӻ��
from emp e, emp m      -- alias �ʼ�!!
where e.mgr = m.empno; -- e ���̺��� manager��ȣ�� m ���̺��� �����ȣ�̴ϱ�! key���� ���� �ƴ� ���� �߿�!

-- ���ӻ�簡 ���� KING�� �������Ϸ���?
select e.ename as ���, m.ename as ���ӻ��
from emp e, emp m      
where e.mgr = m.empno(+);   -- left outer join ���!



-------------------------
-- conn n1/n1
-------------------------

-- employees(���)���̺��� �̿��ؼ�, ������ ������� ���.
select e.last_name, m.last_name
from employees e, employees m       -- alias �ʼ�!!
where e.manager_id = m.employee_id;

select e.last_name as ���, m.last_name as ���
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by m.last_name;






---- <<<ANSI JOIN>>>

/* Oracle join�� ANSI join���� �Ẹ��...! */

---------------------------1) JOIN ~ ON -----------------------------------------

-------- equi join(inner join)

/* Oracle join�� FROM���� 2���̻� ���̺� ������ ,��� INNER JOIN�� ����,  where ��� ON ����!*/

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

--employees(���)���̺�� departments(�μ�)���̺��� �����ؼ� ������ �μ����� ���.
select last_name, department_name
from employees e JOIN departments d     --�׳� JOIN�� �ص� �Ǳ���
ON e.department_id = d.department_id;

select e.last_name, d.department_id, d.department_name
from employees e INNER JOIN departments d
ON e.department_id = d.department_id;   



-------- outer join

/* Oracle join�� �ٸ��� (+)�� ������ �ʰ� �ƿ� ���������(LEFT, RIGHT, FULL) �����.*/
   

-------------------------
-- conn scott/scott
-------------------------

select e.ename, d.dname
from emp e INNER JOIN dept d
ON e.deptno = d.deptno                   
order by ename;     --11����. JONES �ȳ���


-- left join
select e.ename, d.dname
from emp e LEFT JOIN dept d
ON e.deptno = d.deptno   
order by ename;           -- �Ҽ� �μ��� ���� ����� ������


-- right join 
select e.ename, d.dname
from emp e RIGHT JOIN dept d
ON e.deptno = d.deptno   -- �� ���� �Ҽӵ� ����� ���� �μ��� ������          
order by ename;


-- full join  -> ANSI join������ ���� ��.
select e.ename, d.dname
from emp e FULL JOIN dept d
ON e.deptno = d.deptno   -- ���� ��� �Ѵ� ������.              
order by ename;



------------------------
-- conn n1/n1
------------------------

-- employees(���)���̺�� departments(�μ�)���̺��� �����ؼ� ������ �μ����� ���.
--(1) �μ��� ���� ����� ��� (left join)
select e.last_name, d.department_name
from employees e LEFT JOIN departments d
ON e.department_id = d.department_id;

--(2) ����� ���� �μ��� ��� (right join)
select e.last_name, d.department_name
from employees e RIGHT JOIN departments d
ON e.department_id = d.department_id;

--(3) �μ��� ���� ���, ����� ���� �μ� �Ѵ� ��� (FULL join)
select e.last_name, d.department_name
from employees e FULL JOIN departments d
ON e.department_id = d.department_id;



-------- non equi join

-------------------------
-- conn scott/scott
-------------------------

select e.ename, e.sal, s.grade
from emp e INNER JOIN salgrade s    --��������� INNER ǥ�����ִ� ���� ����.
ON e.sal between s.losal and s.hisal; -- =(where s.losal <= e.sal and e.sal <= s.hisal;) 


-------------------------
-- conn n1/n1
-------------------------

-- employees(���)���̺�� job_grades ���̺��� �����ؼ� ������ �޿�, �޿������ ���.
select e.last_name as �����, e.salary as �޿�, j.grade_level as �޿����
from employees e INNER JOIN job_grades j
ON e.salary between j.lowest_sal and j.highest_sal;



-------- self join

/*�ڱ� ���̺� �ȿ��� join�ؾ� �� ��쿡 ����.
  self join������ ���̺��� alias�� �ʼ�!! (�տ� join������ �ɼ��̿���...)*/
  
-------------------------
-- conn scott/scott
-------------------------
select e.ename as ���, m.ename as ���ӻ��
from emp e INNER JOIN emp m      -- alias �ʼ�!!
ON e.mgr = m.empno; -- e ���̺��� manager��ȣ�� m ���̺��� �����ȣ�̴ϱ�! key���� ���� �ƴ� ���� �߿�!

-- ���ӻ�簡 ���� KING�� �������Ϸ���?
select e.ename as ���, m.ename as ���ӻ��
from emp e LEFT JOIN emp m      
ON e.mgr = m.empno(+);   -- left outer join ���!



-------------------------
-- conn n1/n1
-------------------------

-- employees(���)���̺��� �̿��ؼ�, ������ ������� ���.
select e.last_name, m.last_name
from employees e INNER JOIN employees m       -- alias �ʼ�!!
ON e.manager_id = m.employee_id;

select e.last_name as ���, m.last_name as ���
from employees e LEFT JOIN employees m
ON e.manager_id = m.employee_id
order by m.last_name;



---------------------------2) Natural JOIN------------------------------------

-------------------------
-- conn scott/scott
-------------------------

select ename, dname
from emp natural join dept; --emp ���̺��� deptno �÷��� dept ���̺��� deptno �÷��� �����ϹǷ� �� ����.



-------------------------
-- conn n1/n1
-------------------------

select last_name, department_name
from employees natural join departments; /* department_id �Ӹ��ƴ϶� 
��� ���̺��� manager_id �÷��� �μ� ���̺��� manager_id�� join ������ �ڵ����� �����ϰ� �Ǵµ�, 
������̺����� ����� �ǹ��ϰ� �μ����̺����� �μ����� ���ϱ� ������ �߸��� ����� ������ ��*/




---------------------------3) JOIN ~ USING()------------------------------------

/*���� �ڵ����� join ������ �����Ǵ� Natural join�� ������ �����Ƿ�, 
"using ()"�� �Ἥ ��������� � �÷����� join���� �� */

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
Oracle JOIN�� �޸� ��������� ǥ���� �Ϻη� cartesian product�� �Ϸ����Ѵٴ� ���� ��Ȯ�ϰ� �� �� ����.
��� ����� ���� �̾Ƴ� -> ���� �����͸� 2��,3��� �ø� �� ������
*/

-------------------------
-- conn scott/scott
-------------------------

select  ename, dname
from    emp cross join dept;    







/*
###2###. Threeways JOIN
*/


--Threeways JOIN(Oracle join����...)

-------------------------
-- conn scott/scott
-------------------------

select  e.ename, d.dname
from    emp e, dept d
where   e.deptno = d.deptno(+);   --1�ܰ�. �̰� �ϳ��� ���̺�(����)�̶�� ��������


select e.ename, d.dname, s.grade
from   emp e, dept d, salgrade s
where  e.deptno = d.deptno(+)
and    e.sal between s.losal and s.hisal;   --2�ܰ�. �̷��� �δܰ迡 ���� join�ϱ�! �׻� �ϳ��ϳ���...�ѹ��� �Ϸ���������


-------------------------
-- conn n1/n1
-------------------------

select  e.last_name as �����, d.department_name as �μ���, j.grade_level as ���
from    employees e, departments d, job_grades j
where   e.department_id = d.department_id(+)
and     e.salary between j.lowest_sal and j.highest_sal;



--Threeways JOIN(ANSI join����...)

-------------------------
-- conn scott/scott
-------------------------

select e.ename, d.dname
from   emp e LEFT JOIN dept d
ON     e.deptno = d.deptno;         --1�ܰ�. �̰� �ϳ��� ���̺�(����)�̶�� ��������

select e.ename, d.dname, s.grade
from   emp e LEFT JOIN dept d
ON     e.deptno = d.deptno
JOIN   salgrade s
ON     e.sal between s.losal and s.hisal;   --2�ܰ�. �̷��� �δܰ迡 ���� join�ϱ�!


-------------------------
-- conn n1/n1
-------------------------

select  e.last_name as �����, d.department_name as �μ���, j.grade_level as ���
from    employees e left join departments d
on      e.department_id = d.department_id
join    job_grades j
on      e.salary between j.lowest_sal and j.highest_sal;




--ANSI join���� ����

select  e.last_name as �����
        ,d.department_name as �μ���
from    employees e left join departments d
on      e. department_id = d.department_id      --1�ܰ�. �μ�id�� left join�ϱ�. 20�� �� ����.



select  e.last_name as �����
        ,d.department_name as �μ���
        ,l.city as ���ø�
from    employees e left join departments d
on      e. department_id = d.department_id
join    locations l
on      d.location_id = l.location_id;          --2�ܰ�. locations���̺� join�ϱ� but, �̷��� �ϸ� ���ܰ迡�� 20���̿�� 19�ٹۿ� �ȳ����� ��




select  e.last_name as �����
        ,d.department_name as �μ���
        ,l.city as ���ø�
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id;          --3�ܰ�. left join�ϱ�. 20�� �� ����.



select  e.last_name as �����
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
join    countries c
on      l.country_id = c.country_id;        --4�ܰ�. countries���̺� join�ϱ�. but, �̷��� �� 19��...




select  e.last_name as �����
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c                     --5�ܰ�. left join�ϱ�. 20�� �� ����.
on      l.country_id = c.country_id;           




select  e.last_name as �����
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
        ,r.region_name as ������
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
join    regions r                           --6�ܰ�. regions���̺� join�ϱ�. but, �̷��� �� 19��...
on      c.region_id = r.region_id;



select  e.last_name as �����
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
        ,r.region_name as ������
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
left join    regions r                      --7�ܰ�. left join�ϱ�. 20�� �� ����.
on      c.region_id = r.region_id;



select  e.last_name as �����
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
        ,r.region_name as ������
        ,e.salary as �޿�
        ,j.GRADE_LEVEL as ���
from    employees e left join departments d
on      e. department_id = d.department_id
left join    locations l
on      d.location_id = l.location_id
left join    countries c
on      l.country_id = c.country_id
left join    regions r
on      c.region_id = r.region_id
join    job_grades j
on      j.lowest_sal <= e.salary and e.salary <= j.highest_sal;     --8�ܰ�. job_grades���̺� join�ϱ��̶��� 20�� �߳���...�̷��� left join �� �� �� �����ϱ� ���� �ϳ��� �ϸ鼭 Ȯ��!!



select  e.last_name as �����
        ,m.last_name as ���
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
        ,r.region_name as ������
        ,e.salary as �޿�
        ,j.GRADE_LEVEL as ���
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
join    employees m                                             --9�ܰ�. employees ���̺� self join�ϱ�. �̷��� ������� �Ѹ����� 19�� ����
on      e.manager_id = m.employee_id; 



select  e.last_name as �����
        ,m.last_name as ���
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
        ,r.region_name as ������
        ,e.salary as �޿�
        ,j.GRADE_LEVEL as ���
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
left join    employees m                                             --10�ܰ�. left join�ϱ�. 20�� �� ����.
on      e.manager_id = m.employee_id; 



select  e.last_name as �����
        ,m.last_name as ���
        ,j2.job_title as ������
        ,d.department_name as �μ���
        ,l.city as ���ø�
        ,C.COUNTRY_NAME as �����
        ,r.region_name as ������
        ,e.salary as �޿�
        ,j.GRADE_LEVEL as ���
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
join    jobs j2                                                 --11�ܰ�. jobs���̺� join�ϱ�. �̶��� 20�� �߳���.
on      e.job_id = j2.job_id;





-------------------------------------------------------
--������_jOIN (oracle)



select      e.last_name as ����̸�, e.salary as �޿�, grade_level as ������, department_name as �μ��̸�, city as ����, country_name as ����, region_name as ����, e1.last_name as ���
from        employees e, job_grades g, departments d, locations l, countries c, regions r, employees e1
where       e.salary between g.lowest_sal and g.highest_sal
and         e.department_id = d.department_id(+)
and         d.location_id = l.location_id(+)
and         l.country_id = c.country_id(+)
and         c.region_id = r.region_id(+)
and         e.manager_id = e1.employee_id(+)
;

select      e.last_name as ����̸�, e.salary as �޿�, g.grade_level as ������, d.department_name as �μ��̸�, l.city as ����, c.country_name as ����, r.region_name as ����, e1.last_name as ���
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
       decode(rnum, 1, department_id, 2, department_id) as �μ�,
       decode(rnum,1,job_id) as ����
      ,sum(sum_sal) as �հ�
from (select nvl(department_id,999) as department_id, job_id, sum(salary) as sum_sal
      from employees
      group by department_id, job_id) 
      cross join
     (select rownum as rnum from employees where rownum <=3)
group by rnum, decode(rnum, 1, department_id, 2, department_id), decode(rnum,1,job_id)
order by 2,3;
-- inline view 
-- view = ������ �����ϰ� �ִ� ��ü

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
--�μ����� �޿��� ���� ���� �ο��� ���� �޿��� �޴� �ο���

select employee_id, last_name, job_id, salary
from employees
where salary < any
                  (select salary
                   from employees
                   where job_id = 'IT_PROG')
AND job_id <> 'IT_PROG'
;
-- any�� �� �߿� �ϳ��� �ش�ǵ� ��, all�� �� �ش�Ǿ���

select * from departments
where not exists
                (select * from employees
                 where employees.department_id=departments.department_id)
;
-- ��ȣ���� �ϰ� �ִ� ����, ������ �����

select e.last_name
from employees e
where e.employee_id not in
                          (select e1.manager_id
                           from employees e1
                           where e1.manager_id is not null);