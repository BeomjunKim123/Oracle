create user C##HR2 identified by 1234
    default tablespace USERS --��ü�� ���� : USERS
    temporary tablespace TEMP; --Ʈ����� �α� : TEMP
    
    
--2. ������ ������ �ο�,(
    --����Ŭ�� ������ �� �ִ� ����, ��ü�� ����, ����, ����)
grant resource, connect to C##HR2;


--3.���̺� �����̽��� ��뷮(����) ����
alter user C##HR2 quota unlimited on USERS;

/* JSP ==> DB ===> guestboard (����) */

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
values('ȫ�浿','aaa@aaa.com','2023.7.6. ���� 3:53:11','ù��° ������', 'ù��° �۳���');