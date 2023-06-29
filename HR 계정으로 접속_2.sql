/* Select 2  */ 

/* 함수 사용 하기 */ 

/* 
  오라클에서 제공해 주는 다양한 기본 제공된 함수
  1. 문자 처리 함수
  2. 숫자 처리 함수 
  3. 날짜 처리 함수 
  4. 변환 함수 
  5. 일반 함수  
*/ 

/*
  1. 문자 함수 :
        UPPER : 대문자로 변환 해주는 함수 
        LOWER : 소문자로 변환 해주는 함수 
        INITCAP : 첫자만 대문자로 변환해주는 함수 
*/ 

/*
    dual : 가상의 테이블 , 단일 함수를 처리 하기 위해 가상으로 만든 테이블, 
*/

select UPPER ('Oracle mania') as 대문자
from dual; 

select LOWER ('Oracle mania') as 소문자
from dual; 

select INITCAP('oracle mania') as 단어의첫자만대문자
from dual; 

select ename as "이름(원본)", LOWER(ename) as 소문자, INITCAP(ename) as 첫자만대문자
from employee; 

-- 
select * 
from employee; 

select * 
from employee 
where ename = UPPER('ward'); 

/* 
    문자의 길이를 처리하는 함수 
    LENGTH : 글자수를 반환 ( 한글을 1byte)
    LENGTHB : 글자수를 반환 (한글을 3byte)로 처리 <== UTF-8   
*/
-- 글자수를 리턴 
select LENGTH ('Oracle mania') as 글자수
from dual;

-- 한글 1자는 3byte  ==> 1자로 출력 
select LENGTH('오라클 매니아') as 글자수 
from dual ;

select LENGTHB('Oracle mania') as 글자수 
from dual; 

-- LENGTHB : 한글 1자를 3byte 로 처리 
select LENGTHB('오라클 매니아') as 글자수 
from dual ;

/*
    char(6) : 영문 : 6자, 한글 : 2자      <== 글자의 자릿수가 지정된 경우     : 주민번호 (13) , 은행의 비밀번호 
    varchar2(6) : 영문 : 6자, 한글 : 2자  <== 글자의 자릿수를 알수 없는 경우   : 주소, 메일 
    
    nchar(6) : 유니코드 (3byte) 6자를 입력 : 한글, 일본어, 중국어 , 아스키코드 영문 6자 
    nvarchar2(6) :  유니코드 (3byte) 6자를 입력 : 한글, 일본어, 중국어 , 아스키코드 영문 6자 
    
*/


-- Test01 테이블 생성 
CREATE TABLE test01 (
    name1 char(6) not null , 
    name2 varchar2(6) null, 
    name3 nchar(6) null, 
    name4 nvarchar2(6) null
    ); 
    
drop table test01; 

desc test01; 

-- test01 테이블에 값넣기 
-- name1 : char(6) , name2 varchar2(6) : 영문 6자 , 한글 2자 
-- name3 : nchar(6), name4 nvarchar2(6) : 영문 6자, 한글 6자 
select LENGTH ('abcdefghijklmnopqr') from dual; 

insert into test01 ( name1, name2, name3, name4 ) 
values ('abcdef', 'hijklm', 'abcde6', '오라클매니아');

insert into test01 ( name1, name2, name3, name4 ) 
values ('abcdef', 'hijklm', 'abcde6', 'abcdefg');

insert into test01 (name1, name2) 
values ('오늘은', '날씨는') ; 

select * from test01; 

-- 실제 테이블의 글자수를 읽어오기 
select * from employee; 

select ename , length(ename) as 이름의글자수 
from employee; 

/*
    CONCAT : 문자열을 연결 시켜주는 함수 
    SUBSTR : 문자를 잘라내는 함수 , 한글 1자를 1byte로 처리함. 
    SUBSTRB: 문자를 잘라내는 함수,  한글 1자를 3byte로 처리함. 
    INSTR : 특정 문자의 위치값을 반환 ( 한글 1byte) 
    INSTRB : 특정 문자의 위치값을 반환 ( 한글 3byte)
    LPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (왼쪽)
    RPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (오른쪽)
    TRIM : 공백을 제거하는 함수 (앞, 뒤 )
    RTRIM : 오른쪽의 공백을 제거 
    LTRIM : 왼쪽의 공백을 제거 
    
*/ 

select 'Oracle', 'mania' ,
        concat ('Oracle', ' mania')
from dual ; 

select * from employee; 

select ename, job, concat(ename, job) as 컬럼연결 from employee; 

-- substr : 문자열을 잘라오는 함수 : substr(컬럼, 4,3 ) --- 컬럼의 4번째 자리에서 3자를 잘라와서 출력 
select substr('Oracle mania', 4,3)  
from dual; 

select substr('오라클 매니아', 5,3)
from dual; 

select substrb('Oracle mania', 4,3)  
from dual; 

select substrb('오라클 매니아', 4,3)
from dual;

-- 실제 테이블에서 사용 
select * from employee; 

select  hiredate, substr(hiredate, 1,2)  as 연도만출력 , substr(hiredate, 4,2)  as 월만출력
        , substr(hiredate, 7,2)  as 일만출력
from employee ; 

-- INSTR : 특정 문자의 위치를 출력,  
-- Oracle mania 에서 a라는 단어가 들어간 자릿수 : 3
select instr('Oracle mania', 'a') 
from dual; 

-- 4번째 자리 이후 부터 검색 : a가 들어간 자릿수 : 9 
select instr('Oracle mania', 'a' , 4 ) 
from dual; 

-- 사원 이름 컬럼에 'K' 글자가 들어간 자릿수를 검색 : 검색이 되지 않는경우 : 0 , 
select ename , instr(ename, 'K')
from employee; 

-- LPAD :  LPAD ( 컬럼, 자릿수를늘림,'*')   : 특수문자를 왼쪽에 출력 
-- RPAD :  RPAD ( 컬럼, 자릿수를늘림,'*')   : 특수문자를 오른쪽에 출력 
select salary , LPAD (salary, 10, '*'), RPAD (salary, 10, '*')
from employee; 

-- 주민번호(13자리) : 230627-1234567   : 전체 : 14자리 , 230627-1******
    -- substr 를 해서 잘라내고, RPAD를 사용해서 오른쪽은 *표로 처리 출력
    -- length 함수를 사용 
    -- dual 테이블을 적용해서 출력 

select '230627-1234567' as 주민번호, 
        RPAD ( substr('230627-1234567', 1,8), length('230627-1234567'),'*') as 주민번호2
from dual; 

select * from employee; 

-- 이름, 입사일을 출력시 년도월** 로 출력  
select ename as 이름, RPAD( substr(hiredate,1,6), length(hiredate), '*')
from employee; 

-- trim 을 사용해서 공백 제거 : DataBase에 저장하기전 client 에서 문자열의 앞뒤 공백을 제거후 DB에 저장  

select '     Oracle mania       ' as 원본, 
        RTRIM ('     Oracle mania       ') as 오른쪽공백제거, 
        LTRIM ('     Oracle mania       ') as 왼쪽공백제거,
        TRIM ('     Oracle mania       ') as 앞뒤공백제거
from dual ;

/* 2. 숫자함수  
    ROUND : 특정 자릿수에서 반올림 처리 하는 함수    <== 연산시 소점자리를 반올리해서 처리 
            5이상은 반올림 , 5이하는 없앰. 
    ROUND (대상) : 소숫점 뒷자리에서 반올림. 
    ROUND (대상, 소숫점자릿수) : 
        - 양수일때 : 소숫점 기준으로 오른쪽으로 이동해서 반올림 , 그 자릿수 뒤에서 반올림  <== 주의 
        - 음수일때 : 소숫점 기준으로 왼쪽으로 이동해서 반올림, 그 자리에서 반올림됨 
    TRUNC : 특정 자릿수에서 잘라서 버림 
    MOD  : 나머지 값만 반환 
*/ 

select 98.7654 as 원본 , 
        round (98.7654),         -- 99 
        round (98.7654, 2),      -- 98.77 소숫점 오른쪽으로 2자리이동후 그 뒤에서 반올림 
        round (98.7654, -1),     -- 100   소숫점 왼쪽으로 1자리 이동후 그 자리에서 반올림 
        round (98.7654, -2),     -- 100
        round (98.7654, -3),      -- 0 
        round (98.7654, 3)        -- 98.765  소숫점 오른쪽으로 3자리이동후 그 뒤에서 반올림   
from dual; 

select ROUND(1234/34, 2 ) 
from dual; 

select * from employee; 

-- 월 근로소득세를 출력 : 월급 * 0.033
select salary , salary * 0.033  as 근로소득세
from employee; 

-- TRUNC : 특정 자릿에서 버림. 
select trunc(98.7654),       -- 98 소숫점 뒤는 모두 버림 
        trunc(98.7654, 2 ),   -- 98,76    소숫점 2자리 그 뒤는 모두 버림 
        trunc(98.7654, -1 ),   -- 90       소숫점 왼쪽으로 1자리이동후 버림 
        trunc(98.7654, 1 )     -- 98.7
from dual ; 

-- MOD ( 대상, 나누는수) : 대상을 나누는 수로 나누어서 나머지만 출력 

-- 31을 나누엇 ??만 출력, 나머지출력 
select trunc ( 31/2  ) as ??만출력 ,  MOD (31, 2) as 나마지만출력
from dual ; 


1. 덧셈 연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상을 계산한후 사원이름, 급여, 인상된 급여를 출력하세요. 
2. 사원의 이름, 급여, 연간 총 수입이 많은것 부터 작은순으로 출력 하시오. 
    연간 총 수입은 월급에 12를 곱한후 $100의 상여금을 더해서 계산 하시오. 
3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은것 부터 작은순으로 출력하세요. 
4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요. 
5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력 하세요. 
6. 1981년 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일을 출력하시오
7. 부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오. 
8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요. 
9. 1981년도 입사한 사원의 이름과 입사일을 출력 하시오 ( like 연산자와 와일드 카드 사용 : _ , % )
10. 관리자가 없는 사원의 이름과 담당업무를 출력하세요.
11. 커밋션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여 및 커밋션을 기준으로 내림차순 정렬하여 표시하시오.
12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오.
13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오.
14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이며서 
    급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.
15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.  
    --완료 시간 : 17: 20분까지 : p.jangwoo@gmail.com


select * from employee; 
/* order by 에서 두 개이상의 컬럼이 정렬될때   */ 
select * 
from employee
order by job asc ; 

-- job asc, ename desc 
-- 두개 이상의 컬럼이 정렬될때, job 컬럼을 정렬후, job 컬럼의 중복된 값에대해서 ename desc 정렬됨 
select * 
from employee
order by job asc, ename desc ; 

select * 
from employee
order by dno desc, ename asc; 

/* 날짜 함수 
    SYSDATE : 현재 시스템의 날짜를 출력 하는 함수, 
    MONTHS_BETWEEN : 두 날짜 사이의 개월 수를 출력 
    ADD_MONTHS : 특정 날짜에 개월수를 더할때 사용 
    NEXT_DAY : 특정 날짜에서 초래하는 요일을 인자로 받아서 요일이 도래하는 날짜를 출력 
    LAST_DAY : 달의 마지막 날짜를 반환 
    ROUND : 날짜를 반올림 하는 함수, 15일이상 : 반올림, 15미만 : 삭제 
    TRUNC : 날짜를 잘라내는 함수   
*/ 
-- 현재 시스템의 날짜를 출력 : 년/월/일 
select sysdate 
from dual; 

select sysdate - 1 as 어제, sysdate as 오늘, sysdate + 1 as 내일
from dual; 

select * from employee; 

-- 입사일로부터 오늘날짜까지 몇일 근무했는지 출력 
select ename 이름, hiredate 입사일, Round(sysdate - hiredate) 총근무일수 
from employee; 

-- 입사일로 부터 1000일 지난 시점의 날짜를 출력. 
select ename 이름, hiredate 입사일, hiredate + 1000 입사천일날짜 
from employee; 

-- 특정날짜에서 월을 기준으로 출력 
select hiredate as 원본, trunc ( hiredate, 'MONTH') , ROUND (hiredate, 'MONTH')
from employee; 

-- months_between : 두 날짜 사이의 개월 수를 출력 
-- 입사일로 부터 현재까지의 근무한 개월수를 출력 
select ename, hiredate , trunc (months_between( sysdate, hiredate)) as 근무개월수 
from employee

-- date (날짜타입) 
-- add_months (날짜, 개월수) : 날짜에 개월수를 더하는 함수 
-- 오늘날짜에 100개월을 더한 날짜
select sysdate as "오늘날짜", add_months (sysdate , 100) as "100개월후" , sysdate + 100 as "100일후"
from dual;

-- 입사후 6개월이 지난 시점을 출력 
select ename, hiredate , add_months(hiredate, 6) as "입사후6개월시점"
from employee; 

-- next_day : 특정날짜에서 요일을 인풋으로 넣어서 도래하는 요일의 날짜를 출력 
select next_day (sysdate, '월요일')
from dual; 

-- last_day (date) : date의 마지막 날짜 를 출력 
select sysdate as 오늘날짜, last_day(sysdate)   
from dual; 

-- 사원테이블에서 입사일의 마지막 날짜를 출력 
select hiredate as 입사일, last_day(hiredate)
from employee; 

/* 형식 변환 함수 
    TO_CHAR : 날짜, 숫자형을 문자형으로 변환 
    TO_DATE : 문자형을 날짜형으로 변환 
    TO_NUMBER : 문자형을 숫자로 변환 
*/ 

-- TO_CHAR (date, 'YYYYMMDD') : 날짜형식을 'YYYYMMDD' 형식으로 뽑아와서 char 타입으로 변환 

select TO_CHAR (sysdate, 'YYYYMMDD') 
from dual; 




-- <<문제 풀이 시작>>
1. 덧셈 연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상을 계산한후 사원이름, 급여, 인상된 급여를 출력하세요. 
desc employee; 

select * 
from employee; 

select eno as 사원번호, ename 사원명, job 직책, manager "직속상관  ID",
    hiredate 입사날짜, salary 월급, commission 보너스, dno 부서번호
from employee; 

select ename, salary, salary + 300 as 인상된급여
from employee; 

2. 사원의 이름, 급여, 연간 총 수입이 많은것 부터 작은순으로 출력 하시오. 
    연간 총 수입은 월급에 12를 곱한후 $100의 상여금을 더해서 계산 하시오. 
    
    select ename, salary, commission from employee; 
    
    select ename, salary,commission,salary *12, salary *12 + NVL(commission,0) + 100 as 총연봉
    from employee;   
     
3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은것 부터 작은순으로 출력하세요. 

desc employee;

select ename, salary    -- 컬럼명
from employee           -- 테이블, 뷰
where salary >= 2000    -- 조건
order by salary desc    -- 정렬 

4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요. 
select ename, dno ,eno
from employee
where eno = 7788

5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력 하세요. 
select ename, salary 
from employee
where salary not between 2000 and 3000; 

6. 1981년 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일을 출력하시오

select ename, job, hiredate
from employee
where hiredate between '1981/2/20' and '1981/5/1'; 

7. 부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오. 
select ename, dno 
from employee
where dno = 20 or dno = 30 
order by ename asc; 

select ename, dno 
from employee
where dno in ( 20, 30 )
order by ename asc; 

8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요. 
select ename, salary, dno 
from employee
where (salary between 2000 and 3000) and (dno in (20,30)) 

9. 1981년도 입사한 사원의 이름과 입사일을 출력 하시오 ( like 연산자와 와일드 카드 사용: _ , %)
select ename, hiredate 
from employee 
where hiredate like '81%';


10. 관리자가 없는 사원의 이름과 담당업무를 출력하세요.
select * from employee; 

select ename, manager
from employee
where manager is null ; 


11. 커밋션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여및 커밋션을 기준으로 내림차순 정렬하여 표시하시오. 
select * from employee
order by commission desc; 

select ename, salary, commission 
from employee
where commission is not null
order by salary desc, commission desc

12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오.
select ename 
from employee
where ename like '__R%' 

select ename
from employee
where instr(ename, 'R', 3)=3;

select ename , instr(ename, 'R', 3) from employee; 


13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오.
select ename 
from employee
where ename like '%A%' and ename like '%E%'

select ename 
from employee
where instr(ename, 'A')!=0 and instr(ename, 'E')!=0;

14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이며서 
    급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.

select ename, job, salary 
from employee
where (job = 'CLERK' or job = 'SALESMAN') and salary not in ( 1600,950, 1300) 

select ename , job , salary 
from employee
where job in ('CLERK', 'SALESMAN') and salary not in (1600,950,1300);
    
15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.  
select ename, salary ,commission
from employee
where commission >= 500; 

-- <<문제풀이 완료>>