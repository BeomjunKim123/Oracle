/* CRUD : Create, Read, Update, Delete */

/* 테이블 생성 */
create table myTest (
    idx number not null,
    name varchar2(10) not null,
    pass varchar2(50) not null,
    addr varchar(100) null,
    email varchar2(100) null
    );
    
/* 테이블의 내용을 출력 */
select * from myTest;

/* 테이블에 값을 입력 */
insert into myTest (idx, name, pass, addr, email)
values ( 1, '홍길동', '1234', '서울', 'aaa@aaa.com');

insert into myTest (idx, name, pass, addr, email)
values ( 2, '홍길순', '1234', '부산', 'bbb@bbb.com');

commit; --트랜잭션을 완료(insert / update / delete )

/* 기존의 테이블의 값을 수정 : update는 where 조건을 처리 */
update mytest
set addr = '광주'
where idx = 2;

commit;

/* 기존 테이블의 값을 삭제 : delete */
delete mytest
where idx = 2;


