/* select 3 */
/* 형식 변환 함수 
    TO_CHAR : 날짜, 숫자형을 문자형으로 변환 
    TO_DATE : 문자형을 날짜형으로 변환 
    TO_NUMBER : 문자형을 숫자로 변환 
*/ 

-- TO_CHAR (date, 'YYYYMMDD') : 날짜형식을 'YYYYMMDD' 형식으로 뽑아와서 char 타입으로 변환 

/*
    YYYY : 날짜 정보의 년도를 뽑아냄 
    YY   : 년도의 마지막 2자리 뽑아옴 
    MM   : 월
    MON   : 
    DD   : 일 
    
    DAY  : 요일을 뽑아옴 ( 월요일, 화요일, ...일요일)
    DY   : 요일을 뽑아옴 ( 월, 화, ...일)
    
    HH  : 시간 
    MI  : 분 
    SS : 초 
*/


select TO_CHAR (sysdate, 'YYYY/MM/DD'), TO_CHAR(sysdate, 'YYYY-MM-DD DAY HH:MI:SS')  
from dual; 

select sysdate , TO_CHAR (sysdate , 'YY/MM/DD_HH:MI:SS_DY')
from dual; 

select * from employee; 

desc employee; 

select hiredate , TO_CHAR ( hiredate, 'YYYY-MM-DD DAY HH:MM:SS') 
from employee; 

-- TO_CHAR : 날짜 , 숫자 ==> 문자형으로 변환 

/*
    0 : 자릿수를 처리함, 자릿수가 맞지 않으면 0으로 처리됨 
    9 : 자릿수를 처리함, 자릿수가 맞지 않으면 공백 처리됨 
    L : 각 지역의 통화를 기호로 표시 
    . : 소숫점으로 처리 
    , : 천단위 구분자 
*/ 

desc employee; 

select ename , salary , to_char(salary, 'L999,999'), to_char(salary, 'L000,000') 
from employee; 

-- TO_DATE   :  문자형, 숫자 => 날짜타입으로 변환    
    /*
        TO_DATE (변환할문자[숫자], YYYYMMDD)
    */

select TO_DATE(20230628, 'YYYYMMDD') , TO_DATE ('06282023', 'MMDDYYYY') 
from dual; 

select to_date ( '2001-10-30', 'YYYY-MM-DD') 
from dual ; 

-- 생일에서 오늘날짜까지 몇 일 살았는지 출력 : 1981-04-15  
select TRUNC (sysdate - to_date ('1981-04-15', 'YYYY-MM-DD') )  -- 해당날짜에서 현재까지의 일수 
from dual; 

select to_date ( '12/06/22' , 'MM/DD/YY')  - to_date( '1900-10-17', 'YYYY-MM-DD')  as 두날짜의차
from dual; 


-- 자신의 생일 에서 현재 까지 몇일 살았는지. , 몇개월 지났는지?   1981/01/01
select trunc( sysdate - to_date('1981/01/01' , 'YYYY/MM/DD')) as "살아온일 수", 
        trunc (months_between (sysdate ,to_date('1981/01/01' , 'YYYY/MM/DD'))) as "살아온 개월수" 
from dual; 

-- employee 테이블에서 각사원의 입사일에서 2030/01/01 까지의 근무 개월수를 구함.  
select * from employee; 
select ename , hiredate , 
    trunc (months_between (to_date('2030/01/01','YYYY/MM/DD'), hiredate) ) as  "특정날짜까지개월수"
from employee

-- null 처리 함수 : NVL, NVL2, NULLIF    
/*
    NVL (컬럼, 값) : 컬럼에 NULL이 존재할 경우 값으로 대치 
    NVL2 (컬럼명, null이아닐경우처리, null경우처리블락)   
*/ 
select * from employee; 

-- NVL 함수를 사용해서 처리 -  연봉을 구함.  월급(salary) * 12 + 보너스(commission)  
select ename, salary, commission , 
        salary *12 + NVL (commission,0) as 총연봉
from employee; 

-- NVL2 함수를 사용해서 처리 - 
select ename, salary, commission , 
           NVL2(commission ,salary * 12 +commission , salary*12 ) as 총연봉 
from employee; 

/* 그룹 함수 : group by , 특정 컬럼을 그룹핑해서 처리함.  */ 

select 컬럼명
from 테이블이름[뷰]
where 조건
group by 컬럼명[그룹핑할컬럼명]
having 조건[그룹핑한결과의조건]
order by 컬럼명[정렬할컬럼명] 




/* 집계 함수 : SUM, AVG, MAX, MIN, COUNT    <== null 을 자동으로 처리해서 작동됨 
    NUMBER 타입에서만 사용 가능 
    
    -- SUM : 컬럼의 모든 값을 더하는 함수 
    -- AVG : 컬럼의 모든 값의 평균을 구하는 함수
    -- MAX : 컬럼의 모든 값의 최대값을 가져오는 함수 
    -- MIN : 컬럼의 모든 값의 최소값을 가져오는 함수 
    -- COUNT : 레코드수, 그룹핑된 갯수 출력 
    
    주의 : 단일 row로 출력됨, 다른 컬럼을 같이 사용될 경우 오류가 발생
*/ 

select commission from employee
order by commission asc; 

select SUM(commission) as 합계, 
    AVG(commission) as 평균, 
    MAX (commission) as 최대값, 
    MIN(commission) as 최소값, 
    count (commission) 
from employee; 

select * from employee; 


-- 부서별 월급의 합계, 평균, 최대값, 최소값, 그룹핑된 갯수 
-- dno : 부서번호 가 동일한 값을 그룹해서 처리함. 
select sum (salary) as 부서합계 , dno , count (dno) as 그룹핑된갯수
from employee
group by dno 

select ename, salary, dno 
from employee
order by dno asc; 

-- 부서별로 월급의 합계, 평균, 최대월급, 최소월급, 그룹핑된수를 출력 
select sum(salary), round (avg(salary)), max(salary), min(salary), dno 부서번호 , count(dno) 그룹핑수
from employee
group by dno 
order by dno asc; 

select salary from employee where dno = 20; 


select ename, job , salary 
from employee; 

-- 직급 별로  월급의 합계, 평균, 최대값, 최소값, 그룹핑된수 
select sum (salary), round (avg(salary)) as 평균, max (salary), min(salary), job, count(job) 
from employee
group by job 
having round (avg(salary)) > 2000
order by 평균 desc

-- group by 에서 
  /*
    where 절  :  <조건> : group by 전에 조건을 처리해서 나온 결과만 group by 
    having 절 :  <조건> : group by 한 결과에 대한 조건처리 , 별칭이름을 사용하면 안됨.
    order by 는 별칭이름 사용가능 
  */ 
  
-- 직급별로 월급의 합계, 평균, 최대값, 최소값을 출력하되 20부서는 빼고, 평균이 2000 이상인것만 출력 하라. 
-- 평균을 내림차순으로 정렬하라. 

select sum (salary), round (avg(salary)) as 평균, max(salary), min(salary), job, count(*) 그룹핑수 
from employee
where dno not in (20) 
group by job
having round (avg(salary)) >= 2000 
order by round (avg(salary)) desc


-- 두 컬럼 이상 그룹핑을 할 수 있다. 두 컬럼모두가 동일할때 그룹핑 이됨.  
select dno, job
from employee
order by dno , job 

-- 부서번호와 직책컬럼 모두를 그룹핑 해서 월급의 합계, 평균, 최대값, 최소값, 그룹핑된수 
select sum (salary), round (avg (salary)), max (salary), min(salary), count (*) 그룹핑된수
from employee
group by dno, job 
order by 그룹핑된수 desc; 


-- 각 직책에 대해서 월급의 합계, 평균, 최대값, 최소값을 출력하는데 입사일이 81년도에 입사한 사원들만 출력하되
-- 월급의 평균이 1500 만원이상이것만 출력하고 평균을 내림 차순으로 정렬해서 출력 . 

select sum(salary), round(avg (salary)) as 평균, max (salary), min (salary), job , count(*)
from employee
where hiredate like '81%'
group by job
having (avg (salary)) > 1500
order by 평균 desc; 

select count (*) 
from employee
where hiredate like '81%'

-- rollup : 그룹한 결과 마지막 라인에 전체 결과를 출력 ,
-- cube   : 각 그룹핑의 마지막 라인에 결과출력, 제일 마지막 라인에 전체 결과도 함께 출력 

-- rollup , cube 를 사용하지 않는 그룹핑 쿼리 
-- gropup by 절에서 컬럼 2개 가 그룹핑 될때 두 컬럼에 걸쳐서 중복을 그룹핑 
select sum(salary), round (avg(salary)) as 평균, max(salary), min(salary), dno,job , count(*) 
from employee
group by dno, job  
order by dno asc; 

select dno, job 
from employee
order by dno asc, job asc; 



-- rollup 을 사용
select sum(salary), round (avg(salary)) as 평균, max(salary), min(salary), dno,job , count(*) 
from employee
group by rollup (dno,job)
order by dno asc; 

-- cube 를 사용
select sum(salary), round (avg(salary)) as 평균, max(salary), min(salary), dno , count(*) 
from employee
group by cube (dno)
order by dno asc; 

/* SubQuery (서브 쿼리) : Select 내부의 select 구문, 여러번 작업을 하나의 퀄리에서 실행
        where 절에서 많이 사용함. 
*/ 

-- ename 이 SCOTT 인 사원과 동일한 직책의 사원들을 출력하라. 
/*
   1. ename 이 SCOTT인 사원의 직책을 가져오는 쿼리 
   2. 직책을 조건으로 해서 사원을 알아 와야하는 쿼리 
*/ 
select * from employee; 

select job 
from employee 
where ename = 'SCOTT'; 

select ename from employee where job = 'ANALYST'; 

-- SubQuery를 사용해서 ename 이 SCOTT 인 사원과 동일한 직책의 사원들을 출력하라.
select ename, salary, job 
from employee
where job = ( select job from employee where ename='SCOTT' ); 

-- SMITH 와 동일한 부서를 가진 사원들을 출력 하기 (subquery) 
select dno from employee where ename='SMITH'; 
select ename from employee where dno = 20; 

select ename from employee where dno =(select dno from employee where ename='SMITH'); 

-- 'SCOTT' 의 월급보다 많은 사원 정보 출력 하기 
select ename, salary 
from employee
where salary > (Select salary from employee where ename='SCOTT'); 

-- 최소 급여를 받는 사원의 이름과 담당업무 , 급여 출력 하기 
select ename, job, salary
from employee
where salary = ( select min(salary) from employee )

-- 단일 값이 아니라 여러개의 값이 출력될 경우 IN 키워드를 사용 

-- Subquery 를 사용 
-- 부서별로 최소급여를 받는 사원 정보의 이름, 직책, 월급 을 출력, group by , min , in 키워드 사용해서 출력 
select ename 이름, job 직책, salary 월급 , dno 부서번호
from employee
where salary in (
    select min (salary) 
    from employee
    group by dno 
)  ; 

-- 각 부서의 최소 급여가 30번 부서의 최소 급여 보다 큰 부서를 출력 ;  ( 5분 ) 
   1. 30번부서의 최소급여 
   2. 각 부서의 최소급여를 출력후 having 
   
select min(salary), dno , count(*)
from employee 
group by dno
having min(salary) > ( 
    -- 30번 부서의 초소급여를 출력
    select min(salary) from employee 
    where dno = 30 
) ; 

/*
    ANY 연산자 : 서브쿼리가 반환하는 각각의 값과 비교함. 
       --  < any 는 최대값 보다 작음을 나타냄. 
       --  > any 는 최소값 보다 큼을 나타냄. 
       --  = any 는 IN 과 동일한 키워드 
       
    ALL 연산자 : 서브쿼리에서 반환되는 모든 값을 비교함. 
        --  < all 는 최소값 보다 작음 나타냄  
        --  > all 는 최대값 보다 큼을 나타냄
*/ 

-- 직급이 SALESMAN이 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력 
select * from employee order by job asc ; 


-- ALL 연산자를 사용해서 출력 
select ename, job, salary 
from employee 
where salary < all ( select salary from employee
                       where job = 'SALESMAN') 
    and job != 'SALESMAN';    -- !=    ,    <> 

-- min 을 사용해서 출력 
select ename, job, salary 
from employee 
where salary <  ( select min(salary) from employee
                       where job = 'SALESMAN') 
    and job != 'SALESMAN';

-- 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분서가가 아닌사원들을 출력 

-- ALL 연산자를 사용해서 출력 
select ename, job, salary 
from employee 
where salary < all ( select salary from employee
                       where job = 'ANALYST') 
    and job != 'ANALYST';    -- !=    ,    <> 

-- min 을 사용해서 출력 
select ename, job, salary 
from employee 
where salary <  ( select min(salary) from employee
                       where job = 'ANALYST') 
    and job != 'ANALYST';
  
  =====================================================================  
1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
4. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
5. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
6. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
   데이터 형식을 일치 시키시오.
7. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
8. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
9. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
10.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"       
11.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	dual 테이블 사용
=============================================================================
1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select * from employee; 
select substr ( hiredate, 1,5 ) as 년월 
from employee; 

2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
select ename, hiredate 
from employee
where  substr (hiredate, 4, 2)  = 04; 

3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select ename, manager 
from employee
where MOD (manager , 2) = 1; 

4. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.

select ename, salary 
from employee
where MOD ( salary , 3) = 0 ; 

5. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select hiredate , to_char ( hiredate, 'YY MON DD DY') as 출력결과 
from employee; 

6. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
   데이터 형식을 일치 시키시오.
  select trunc (sysdate - to_date ( 20220101 , 'YYYYMMDD')) as 올해날짜수 from dual  
   

7. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
 select trunc (sysdate - to_date ( 19800101 , 'YYYYMMDD')) as 총날짜수 from dual  

8. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc( months_between (sysdate , to_date ( 19800101 , 'YYYYMMDD'))) as 총개월수 from dual  

9. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
select ename, manager , nvl (manager, 0), nvl2 (manager, manager,0)
from employee; 

10.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"
       
    select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as 가린번호 ,  
    ename, rpad ( substr (ename, 1,1), 4,'*')
    from employee;
    
        select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as 가린번호 ,  
    ename, rpad ( substr (ename, 1,1), length (ename),'*')
    from employee;
      
    select ename, length(ename)
    from employee; 
       
11.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	dual 테이블 사용
    
    select  RPAD (substr ('801210-1234578', 1,8) , length ('801210-1234578'), '*') as 주민번호,
            RPAD ( substr ('010-1234-5678', 1,6), length ('010-1234-5678'), '*') as 전화번호
    from dual 
    



=============================================================================
모든 평균은 소숫점 2자리까지 출력하되 반올림 해서 출력 하시오.  
1.  10 번 부서를 제외하고 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
2.  직책의 SALSMAN, PRESIDENT, CLERK 을 제외한 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오.   	
3. SMITH 과 동일한 부서에 근무하는 사원들 의 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
4. 부서별 최소월급을 가져오되 최소월급이 1000 이상인 것만 출력하세요. 
5.  부서별 월급의 합계가 9000 이상것만 출력
6.  부서별 월급의 평균이 2000 이상만 출력
7. 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력 하라. 
8. sub query - 부서별로 최소 급여를 받는 사용자의 이름과 급여와 직책과 부서번호를 출력하세요. 
9. sub query - 전체 평균 급여보다 많이 받는 사용자의  이름과 급여와 직책과 부서번호를 출력하세요. 
10. sub query - 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해 오름차순 정렬하시오. 
==============================================================================
모든 평균은 소숫점 2자리까지 출력하되 반올림 해서 출력 하시오.  
1.  10 번 부서를 제외하고 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select sum (salary), round (avg(salary),2), max(salary), min(salary), dno, count(*)
from employee
where dno not in (20)
group by dno
order by dno

2.  직책의 SALSMAN, PRESIDENT, CLERK 을 제외한 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오.  
select sum (salary), round (avg(salary),2), max(salary), min(salary), dno, count(*)
from employee
where job not in ('SALESMAN', 'PRESIDENT', 'CLERK')
group by dno
order by dno

3. SMITH 과 동일한 부서에 근무하는 사원들 의 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select sum(salary), round( avg(salary),2), max(salary), min(salary), dno, count(*)
from employee
where dno = (select dno from employee where ename = 'SMITH')
group by dno

4. 부서별 최소월급을 가져오되 최소월급이 1000 이상인 것만 출력하세요. 
select min (salary), dno, count(*)
from employee
group by dno
having min(salary) > 1000

5.  부서별 월급의 합계가 9000 이상것만 출력

select dno , count(*), sum (salary) as 부서별합계 , round (avg(salary) , 2) as 부서별평균
from employee 
group by dno
having sum (salary) >9000 ; 


6. 부서별 월급의 평균이 2000 이상만 출력

select dno , count(*), sum (salary) as 부서별합계 , round (avg(salary) , 2) as 부서별평균
from employee 
group by dno
having round (avg(salary) , 2) > 2000.00 ; 

7. 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력 하라. 
select dno, count(*) , round (avg (salary)) as 부서별평균
from employee
where salary > 1500
group by dno
having round (avg (salary)) > 2500 

8. sub query - 부서별로 최소 급여를 받는 사용자의 이름과 급여와 직책과 부서번호를 출력하세요. 

select eno, ename, salary, dno
from employee
where salary in (select  min(salary)
                from employee
                group by dno )
                
9. sub query - 전체 평균 급여보다 많이 받는 사용자의  이름과 급여와 직책과 부서번호를 출력하세요. 
select ename, salary, job, dno 
from employee
where salary > ( select avg(salary) from employee); 


10. sub query - 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해 오름차순 정렬하시오. 

select eno, ename,salary from employee
where salary > (select avg(salary) as 평균급여 from employee)
order by salary asc;
