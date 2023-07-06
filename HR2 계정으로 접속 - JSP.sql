create user C##HR2 identified by 1234
    default tablespace USERS --객체들 저장 : USERS
    temporary tablespace TEMP; --트랜잭션 로그 : TEMP
    
    
--2. 계정에 권한을 부여,(
    --오라클에 접속할 수 있는 권한, 객체를 생성, 수정, 삭제)
grant resource, connect to C##HR2;


--3.테이블 스페이스에 사용량(쿼터) 적용
alter user C##HR2 quota unlimited on USERS;

/* JSP ==> DB ===> guestboard (방명록) */

create table guestboard (

    name varchar2(100),
    email varchar2(100),
    inputdate varchar2(100),
    subject varchar2(100),
    content varchar2(100)
    
    );

drop table 
    
select * from guestboard;

ALTER USER C##HR2 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

insert into guestboard (name, email, inputdate, subject, content)
values('홍길동','aaa@aaa.com','2023.7.6. 오후 3:53:11','첫번째 글제목', '첫번째 글내용');