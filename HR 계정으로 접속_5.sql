/* DDL : Alter Table : 기존의 생성된 테이블을 수정 
        - 기존 테이블의 컬럼을 추가, 커럼이름변경, 컬럼삭제, 컬럼의 자료형 수정 
        - 컬럼의 부여된 제약 조건을 생성, 수정, 삭제
*/ 

-- 샘플 테이블 생성 
-- 테이블 복사  : 원본 테이블 : department,  복사 : dept01
    -- 원본 컬럼명, 자료형, 데이타(레코드) 복사 
    -- 원본 테이블의 제약 조건은 복사되어 오지 않음
    
create table dept01 
as 
select * from department; 

create table emp01
as 
select * from employee; 

select * from dept01;

desc dept01 ; 
desc department; 

-- 제약 조건을 확인하는 데이터 사전
show user; 
select * from user_constraints      -- 현재 접속한 계정의 모든 테이블의 제약조건을 확인 
-- where table_name = 'DEPARTMENT'; 
where table_name = 'DEPT01'; 

select * from user_constraints      -- 현재 접속한 계정의 모든 테이블의 제약조건을 확인 
where table_name = 'EMPLOYEE'; 
-- where table_name = 'EMP01'; 

-- DEPT01 테이블에 새로운 컬럼 추가 , null 
select * from dept01; 

-- birth 컬럼 추가 
alter table dept01
add (birth date);

alter table dept01
add (email varchar2(100), addr varchar2(200), jumin char(14));

-- 테이블에 컬럼을 추가할때 null 이 기본, update 구문을 사용해서 값을 넣음. 
update dept01 
set birth = sysdate, email = 'aaa@aaa.com', addr = '서울', jumin = '880520-1111111' 
where dno = 10 ; 
commit; 

-- 컬럼의 자료형 수정 : char, varchar 글자수를 늘림. 
alter table dept01
modify email varchar(200) ; 

desc dept01; 

-- 특정 컬럼 삭제    <==  야간에 작업해야 함. 부하가 많이 걸리는 작업 
alter table dept01
drop column JUMIN ; 

alter table dept01
drop column addr; 

select * from dept01; 

-- 컬럼명 변경 : 
alter table dept01
rename column dno to d_dno ; 

alter table dept01 
rename column birth to birthday; 

-- 테이블 이름 변경 
rename dept01 to dept001; 

rename dept001 to dept01; 

-- 데이터 사전에서 현재로그온한 사용자의 모든 테이블 출력 
select * from user_tables; 
select table_name from user_tables
order by table_name asc; 

/* alter table 을 사용해서 제약조건 생성, 수정, 삭제 
        -- Primary Key
        -- Unique
        -- Foreign Key
        -- Check
        -- Not Null     <== 구문이 다름. 
        
        -- Default 
*/ 

-- 데이터 사전을 통해서 여러 테이블의 제약 조건을 한번에 확인 
select * from user_constraints
where table_name in ('DEPT01', 'DEPARTMENT', 'EMP01', 'EMPLOYEE'); 

-- 기존 테이블에 Primary Key 제약 조건 넣기 
    -- 컬럼의 중복된 값이 없어야 한다. 
    -- 컬럼의 null 들어 있으면 안됨. 
    -- 테이블에 Primary Key 컬럼이 존재하면 안됨 , 테이블에 1 번만 넣을수 있다. 
        
select * from dept01; 

desc dept01; 

-- dept01 테이블에 d_dno 컬럼에 Primary Key 할당
alter table dept01 
add constraint PK_DEPT01_D_DNO primary key (d_dno); 


/* Foreign Key 할당 
     - 부모 테이블의 Primary Key, Unique 컬럼을 참조함. 
     - FK 가 적용된 컬럼과, 부모테이블의 참조컬럼의 자료형이 비슷하거나 같아야 한다. 
     - FK 가 적용된 컬럼의 값은 부모테이블의 참조 값이 들어있어야 한다. 
    */ 
-- EMP01 테이블의 

select * from dept01;   -- 부모 테이블(DEPT01)  : d_dno
select * from emp01;    -- 자식 테이블 : dno    (FK) 

-- emp01 의 dno 컬럼에 FK 할당.    부모 테이블 : d_dno
alter table emp01
add constraint FK_EMP01_DNO foreign key (dno) references DEPT01(D_DNO); 


/* Unique 제약 조건 추가 
    - 컬럼에 중복된 값이 없어야 한다. 
    - null 은 1번만 들어가 있어야 한다. 
    - not null, null 이 적용곳에 부여할 수 있다. 
*/ 

-- EMP01 테이블의 ename 컬럼에 UNIQUE 제약 조건 추가 
select * from emp01; 

alter table emp01 
add constraint U_EMP01_ENAME unique (ename) ; 

-- EMP01 테이블의 eno 컬럼에 Primary Key 제약조건 추가 
alter table emp01
add constraint PK_EMP01_ENO primary key (eno); 

/* check 제약 조건 
    -- 특정컬럼에 조건에 맞는 값만 저장되도록 설정 
    -- salary 컬럼에 조건 : salary > 0 
*/ 

alter table emp01
add constraint CK_EMP01_SALARY check ( salary > 0 ) ; 


/* NOT NULL 제약 조건 추가하기 
    -- 컬럼에 NULL 값이 존재 하지 않아야 한다. 
*/ 
-- job 컬럼에 NOT NULL 제약 조건 추가 
desc emp01; 

alter table emp01
modify job constraint NN_EMP01_JOB not null; 

/* 기존 테이블의 default
    -- default 는 제약 조건이 아니다. 제약조건 이름을 가지지 않는다. 
*/ 

select * from emp01; 

-- commission 컬럼의 값을 넣지 않을 경우 기본값(default) : 0 
alter table emp01
modify commission default 0; 

-- default , null 에 값을 넣을때 : default , null 
insert into emp01 
values ( 8000, '홍길동', '사무원', 7369, sysdate, 2000, default, 40); 

-- 컬럼이 지정되지 않았을때 default , null 
insert into emp01 (eno, ename, job, manager, hiredate,salary, dno)
values ( 8001, '김길동', '사무원', 7369, sysdate, 2000, 40); 


-- 기존 테이블의 제약 조건 제거 : 
       -- 제약 조건 이름으로 제거가 가능 

select * from user_constraints 
where table_name = 'EMP01'; 

select constraint_name from user_constraints 
where table_name = 'EMP01'; 

-- 제약조건 제거 : Primary Key  : PK_EMP01_ENO 
-- 제약조건 제거 : Unique  : U_EMP01_ENAME
-- 제약조건 제거 : Check  : CK_EMP01_SALARY
-- 제약조건 제거 : Not Null  : NN_EMP01_JOB
-- 제약조건 제거 : Foreign Key  : FK_EMP01_DNO

alter table EMP01
drop constraint PK_EMP01_ENO ; 

alter table EMP01
drop constraint U_EMP01_ENAME ;

alter table EMP01
drop constraint CK_EMP01_SALARY ;

alter table EMP01
drop constraint NN_EMP01_JOB ;

alter table EMP01
drop constraint FK_EMP01_DNO ;


-- default  -- 기본값으로 null 설정 
alter table emp01
modify commission default null ; 