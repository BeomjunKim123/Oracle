/* JOIN, VIEW, INDEX, 시퀀스 */ 

/* 테이블 복사 : 

*/ 

create table dept03 
as 
select * from department; 

select * from dept03; 

create table emp03
as 
select * from employee; 

select * from emp03; 

--- 테이블 복사 : 특정 컬럼과 조건을 주어서 복사 

create table salesman01 
as 
select eno, ename, job , salary 
from employee
where job = 'SALESMAN' ; 

select * from salesman01; 

-- 우리회사의 직책만 담은 테이블 생성 (job01) 

select * from employee; 

create table job01
as 
select  distinct job 
from employee ; 

-- 테이블 복사시 제약조건은 복사 되지 않는다. - 컬럼명, 자료형, 레코드(데이타) 복사됨, 
    -- 제약조건은 복사되지 않는다. ( Primary Key, Unique, Foreign Key, Not Null, Check ) 
    
-- 제약 조건 확인  : user_constraints    <== 데이터 사전 : 오라클에서 테이블에 정보를 담은 테이블   
select * from user_constraints
where table_name in ('DEPARTMENT', 'DEPT03', 'EMPLOYEE', 'EMP03'); 

-- Alter Table 을 사용해서 기존 테이블에 제약 조건 추가 
select * from emp03; 
select * from dept03; 

-- EMP03 테이블의 ENO 컬럼에 Primary Key 할당. : 테이블에 1번만 할당, 컬럼에 중복된 데이터가 없어야한다, null 없어야한다. 
desc emp03; 

alter table emp03
add constraint PK_EMO03_ENO primary key(eno) ; 

-- EMP03 테이블의 DNO 컬럼에 Foreign Key :  부모테이블 : DEPT03 DNO 컬럼을 참조 
    -- Foreign Key 가 참조하는 컬럼은 Primary Key, Unique 컬럼을 참조, 
    -- 참조 컬럼의 자료형이 같은거나 비슷 햐야 한다. 
    -- DNO 컬럼의 값이 부모 테이블의 컬럼의 값이 참조된 값이 들어있어야 한다. 
    
desc emp03; 
desc dept03;

-- 부모 테이블의 참조 컬럼은 : Primary Key, Unique 여야 한다. 

alter table dept03
add constraint PK_DEPT03_DNO Primary Key (dno) ; 

alter table emp03 
add constraint FK_EMP03_DNO foreign key (dno) references dept03 (dno) ; 

select * from emp03 ; 

select distinct job from emp03; 


alter table emp03 
add constraint CK_EMP03_SALARY check ( salary > 0 ) ; 

-- EMP03의 JOB 컬럼은 : CLERK, SALESMAN, MANAGER, ANALYST, PRESIDENT 만 넣도록 체크 제약 조건 할당. 
alter table emp03
add constraint CK_EMP03_JOB  check ( job in ('CLERK', 'SALESMAN', 'MANAGER', 'ANALYST', 'PRESIDENT')); 
    
/* JOIN : DataBase에는 많은 테이블이 존재합니다.  각 테이블은 다른 테이블과 관계(FK)를 가지고 있다. 
            RDBMS : 관계형 DBMS 
     -- DB내의 각각의 테이블은 모델링되어있다. ( 중복제거, 성능향상 ) 
     -- 모델링 되지 않는 테이블은 중복된 데이터가 계속 입력됨 <== 하드 공간을 낭비, 성능이 느려진다.
     -- employee 테이블의 dno 컬럼은 부서번호
     -- department 테이블은 부서번호, 부서명, 부서위치 
     -- employee 테이블과 department 테이블을 하나의 테이블로 디자인 되었을 경우 부서 정보가 계속 중복 되어서 들어감. 
    -- 다른 테이블의 컬럼을 출력 하기 위해서는 JOIN을 사용해서 다른 테이블의 컬럼을 출력 
    -- 두 테이블을 JOIN 하기 위해서는 두 테이블의 공통 키 컬럼을 찾아야 한다. ( FK -> PK , UK)  <== ON 
    -- JOIN ANSI 호환 JOIN : 모든 DBMS에서 공통으로 사용하는 JOIN 구문 
            -- Oracle, MSSQL, MYSQL, ....
            
*/ 

select * from employee; 
select * from department; 

/* EQUI JOIN : 오라클에서만 작동하는 JOIN 구문 <===  <<주의 : 공통 키 컬럼은 테이블 이름을 명시 >>>

    select - JOIN 할 테이블의 컬럼을 명시, 두 테이블의 공통의 키 컬럼을 출력시 해당 테이블 명시  
    from - JOIN 할 테이블을 , 로 명시 , 테이블 이름을 별칭으로 사용 
    where - 두 테이블의 공통 키컬럼을 찾아서 '=' 로 처리 
    and - 조건을 처리함. 

*/ 

-- 테이블 별칭(alias) 을 사용해서 조인 
select ENO, ENAME, JOB, d.DNO, DNAME, LOC 
from employee e , department d 
where e.dno = d.dno 
and d.dno = '20'; 

    
-- 테이블 별칭 (alias)을 사용하지 않는 경우 [전체 구문] 
select employee.eno, employee.ename, employee.job, employee.dno, department.dname, department.loc
from employee, department 
where employee.dno = department.dno
and employee.dno= '20' ; 


select eno, ename, job, e.dno, dname, loc
from employee  e, department  d
where e.dno = d.dno
and e.dno= '20' ; 

-- employee 테이블, department 테이블의 전체 컬럼 출력 
desc employee; 
desc department; 

create table emp_dept
as 
select eno, job, manager, hiredate, salary, commission, d.dno, dname, loc 
from employee e, department d
where e.dno = d.dno

select * from emp_dept; 

select * from department; 


/* ANSI JOIN : 모든 DBMS에서 공통으로 사용하는 JOIN 구문 */

/*  INNER 조인 : 두 테이블 모두 공통 키 컬럼의 값이 일치 하는 것만 출력  <== 90 % 이상 사용 
    Select : 두 테이블의 컬럼을 명시, 두 테이블의 공통 키컬럼을 출력시 테이블이름을 명시 
    from 절에 : 테이블1 [inner] JOIN 테이블2
    ON 절에   : 두 테이블의 공통 키 컬럼을 명시 
    where 절에 조건 처리함. 
*/ 

select eno, ename, job, salary , e.dno, dname, loc 
from employee e  join department d
on e.dno = d.dno
where e.dno = '20' ; 


/* Outer JOIN : 한쪽 테이블의 내용은 모두 출력 하도록 함. 
    LEFT Outer JOIN :  왼쪽 테이블은 무조건 모두 출력 
    Right Outer JOIN : 오른쪽 테이블은 무조건 모두 출력
    FULL Outer JOIN : 두 테이블 모두 전체 내용을 출력 
*/ 

-- ANSI 호환의 Outer JOIN 

/*
   조인 실습 테이블 생성 
*/ 
create table emp05
as 
select * from employee; 

create table dept05
as 
select * from department; 

select * from dept05; 
select * from emp05; 

insert into dept05 
values (50, 'HR', 'Seoul'); 
commit; 

-- ANSI 호환 INNER JOIN : 두 테이블의 공통 키컬럼이 일치하는 데이터만 출력 (교집합) 
select ename, job, e.dno, dname, loc 
from dept05 d Inner JOIN emp05 e
on d.dno = e.dno  


-- ANSI 호환 LEFT Outer JOIN : 두 테이블의 공통 키컬럼이 일치하는 왼쪽 테이블의 값은 모두 출력 
select ename, job, e.dno,d.dno dname, loc 
from dept05 d LEFT OUTER JOIN emp05 e
on d.dno = e.dno  

-- Oracle Equie JOIN 

-- 카타르시안 곱 ( 앞 테입블의 모든레코드가 뒷 테이블의 레코드 각 각 매칭 )
-- where 조건에서 두 공통 키 컬럼이 같은 항목만 출력 . 
select  * 
from employee e , department d
where e.dno = d.dno 
and salary > 2000; 

/* NATURAL JOIN : 오라클에서만 사용되는 JOIN,
     - 두 테이블의 공통 키 컬럼을 Oracle 이 자동으로 찾아서 JOIN  
     - Select 구문에 공통 키 컬럼에 테이블을 명시하면 오류가 발생됨 
     - from 절에 NATURAL JOIN 키워드를 사용함.
     - where 절에 공통 키 컬럼을 명시 하지 않음. (오라클에서 두 테이블의 공통 키컬럼을 자동으로 찾아서 처리함. ) 
     - where 절에 조건을 처리함 
*/ 

-- NATURAL JOIN 으로 JOIN  
-- <== 두 테이블의 공통 키컬럼을 자동으로 찾아서 JOIN , select 절에 공통 키 컬럼을 출력시 테이블이름을 명시하면 오류가발생됨

select eno, ename, salary , dno, dname, loc
from emp05 e natural join dept05 d
where salary > 2000; 

-- EQUI JOIn
select eno, ename, salary , e.dno, dname, loc
from emp05 e , dept05 d
where e.dno = d.dno
and salary > 2000; 

-- Ansi SQL JOIN : 모든 DBMS에서 사용되는 구문 : Oracle, MS-SQL, My-SQL, Postgre, MariaDB, ... 
select eno, ename, salary, e.dno dname, loc
from emp05 e join dept05 d
on e.dno = d.dno 
where salary > 2000; 


/* SELF JOIN : 자신의 테이블을 다시한번 JOIN 
      -- 반드시 테이블 별칭을 사용해서 JOIN 해야함.
      -- select 절에 컬럼을 명시할때 별칭이름의 테이블명을 명시해야함. 
      -- 조직도, 상사 정보를 자신의 테이블에서 조회 할때 사용함.       
      */ 

select * from emp05; 

-- SELF JOIN 을 사용해서 사원의 직속 상관정보(이름) 를 출력 

select eno 사원번호 , ename 사원명, manager 직속상관
from employee
where manager= 7788
order by ename asc; 

select eno 사원번호 , ename 사원명, manager 직속상관
from employee
where eno= 7788
order by ename asc; 

-- SELF JOIN 을 사용해서 직속 상관 정보를 한번에 출력 . ( EQUI JOIN) 
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호, m.eno 직속상관사원번호, m.ename 직속상관이름
from emp05 e , emp05 m 
where e.manager = m.eno
order by e.ename asc 

select eno, ename, manager, eno, ename ,manager
from emp05

-- SELF JOIN 을 사용해서 직속 상관 정보를 한번에 출력 . (ANSI JOIN)
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호, m.eno 직속상관사원번호, m.ename 직속상관이름
from emp05 e Join emp05 m 
on e.manager = m.eno
order by e.ename asc 

select * from emp05; 

-- select 문에서 || 를 사용하면 문자열과 연결 할 수 잇음. 
select '사원명 : ' || ename || ' 은 월급이 ' || salary || '입니다.'  as 사원급여정보
from emp05; 

-- 사원명의 직속상관이름을 SELF JOIN으로 바로 출력 
select  e.ename 사원이름, m.ename 직속상관이름
from emp05 e Join emp05 m 
on e.manager = m.eno
order by e.ename asc 

-- KING은 Manager 가 존재하지 않는 정보도 Outer Join 을 통해서 출력 

select  e.ename ||'의 직속상관 이름은 ' || m.ename || ' 입니다' as "사원에 대한 직속상관 명"
from emp05 e  LEFT Outer Join emp05 m 
on e.manager = m.eno
order by e.ename asc 

/* CROSS JOIN : 카타르시안 곱 : 앞테이블의 하나의 레코드에서 뒤테이블의 모든 레코드와 연결 
        : 앞 뒤 테이블의 모든 내용을 곱해서 성능 체크 시 사용. 
*/ 

-- ANSI JOIN 으로 출력 ( 14 * 5 = 70개 레코드 출력 ) 
select * 
from emp05 e cross join dept05 d

-- EQUIE JOIN 
select * 
from emp05 e , dept05 e ; 

show user; 


-- VIEW 생성 할 수 있는 권한 할당 (System 계정으로 접속후 실행 ) 
GRANT CREATE ANY VIEW TO "C##HR" WITH ADMIN OPTION;
GRANT DROP ANY VIEW TO "C##HR" WITH ADMIN OPTION;


-- VIEW : 가상의 테이블 , 코드가 저장된 가상 테이블 
    -- VIEW는 데이터를 가지고 있지 않는다. select 코드가 들어있다. 
    -- 마치 테이블 처럼 사용됨. 
    -- view 는 select 구문이 들어가 있음. 
    
    -- 1. 보안을 위해서 사용됨. ( 실제 테이블의 특정 컬럼만 출력 ) 
    -- 2. 복잡한 쿼리를 저장후 호출해서 사용 ( JOIN, )
 
-- 뷰를 생성 (보안을 위해 생성한 view )     
create view v_emp 
as 
select ename, salary from emp05; 

select * from emp05 ; 

-- 뷰 실행 
select * from v_emp; 

-- view 정보를 확인 하는 데이터 사전 : user_views 
select * from user_views;      -- 현재 로그인한  계정에서 생성된 모든 view를 확인 

-- View 생성 : emp05 테이블과 dept05 테이블을 JOIN 하는 구문 
create view v_emp_dept 
as 
select eno, ename, job, salary, e.dno, dname, loc
from emp05 e , dept05 d
where e.dno = d.dno

-- View 실행 
select * from v_emp_dept; 

drop view v_emp_dept; 


-- 자신의 지속 상사를 출력 하는 view 생성 

select * from emp05 ; 

select eno, ename, manager, eno, ename, manager 
from emp05; 

create view v_sasu_info 
as 
select e.ename 사원원이름 ,e.manager , m.eno,  m.ename 직속상관 
from emp05 e JOIN emp05 m 
on e.manager = m.eno 
order by e.ename asc 

select * from v_sasu_info; 

-- view 의 저장된 코드 정보를 확인 : 데이터 사전을 사용해서 확인 
select * from user_views; 
