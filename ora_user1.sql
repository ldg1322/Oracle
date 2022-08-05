-- 2022/07/26
-- 데이터 타입 
-- 문자 데이터 타입
/*
- CHAR(10) : 고정된 크기를 가진다. : 데이터가 유무에 관계없이 10바이트 크기를 가진다.
최대로 가능한 크기는 2000바이트
ab -> 10바이트
- VACAHR2(10) : 가변 문자열 -> 크기가 데이터의 길이에 따라서 최대 10바이트 사용됨
최대 가능한 크기는 4000바이트
다국어를 저장할 때도 VARCHAR2를 사용
ab -> 2바이트
- NCAHR(10) : 고정길이의 유니코드 형태
최대 2000바이트 -> 유니코드가 2바이트 이므로 4000바이트
- MVARCHAR2(100) : 가변 유니코드(UTF-8)
최대 4000
- LONG : 2GB -> VARHCAR2보다 더 큰 문자열을 저장할 때
    자바의 LONG과는 다르다
    
-- 숫자 데이터 타입
- NUMBER[(p [,s])]
    + p : 유효 자릿수 ( 1~38 )
    + s : 마지막 유효자리수 -> 정수와 소수부분의 자릿수 합 (-84 ~ 127)
    * - 0보다 큰 자릿수를 포함
    * + 0보다 작은 소수점 부분
    * + 소수점 부분만의 유효자릿수을 나타낸다.
- 보통 number 타입을 사용 -> default로 38자리수이다. -> 자바 Long(객체)을 사용한다.
- 자바의 int 형태로 저장하려면 numbedr(9) : 200000000 = 2* 10E9
- 소수점을 저장하려면 number를 사용한다.

-- 테이블 생성
*/
CREATE TABLE ex2_1(
    column1 char(10),    -- 고정 크기 문자열 : 10 바이트
    column2 varchar(10),    -- 가변 크기 문자열 : 최대 10 바이트
    column3 nvarchar2(10),  -- 가변 UTF-8 문자열 10바이트
    column4 number          -- 숫자 : 30 자리
);

-- 열을 추가
INSERT INTO ex2_1 (column1, column2) VALUES ('abc', 'abc');
INSERT INTO ex2_1 (column1) VALUES ('def');
INSERT INTO ex2_1 (column1, column2, column3, column4 ) VALUES ('asd','qwe','한글', 10);

SELECT column1, LENGTH(column1) as len1,
       column2, LENGTH(column2) as len2
    FROM ex2_1;
-- 테이블의 데이터를 검색
SELECT * FROM ex2_1;

-- 새로운 테이블 생성
CREATE TABLE ex2_2(
        COLUMN1 VARCHAR2(3),    -- 디폴트 값인 byte 적용, 최대 영문 3바이트
        COLUMN2 VARCHAR2(3 byte),   -- 최대 영문 3바이트
        COLUMN3 VARCHAR2(3 char)   -- 한글 3자 (6바이트)
);

insert into ex2_2 values ('abc', 'abc', 'abc');    -- 모든 행을 추가할 때, 행을 나열하는 부분을 생략가능
insert into ex2_2 values ('abcd', 'abc', 'abc');   -- 초과로 입력 불가능 : 최대 3 바이트인데 4바이트를 추가
insert into ex2_2 values ('abc', 'abc', '홍길동');  -- 한글 1자에 영문 2바이트에 해당
insert into ex2_2 values ('abc', 'abc', 'abcdef'); -- 영문과 한글을 구분
insert into ex2_2 values ('홍길', 'abc', 'abc');    -- 최대값이 3인데 실제 c (한글 1바이트 영문 3바이트에 해당)
insert into ex2_2 values ('홍', 'abc', 'abc');      -- 한글 1자가 영문 3바이트에 해당

SELECT * FROM ex2_2;

select column3, length(column3) as len3, length(column3) bytelen from ex2_2;
-- 별명 : as 키워드를 사용하거나 생략 할 수 있다.

CREATE TABLE ex2_3(
    col_int integer,
    col_dec decimal,
    col_num number      -- default 38짜리까지 저장할 수 있다.
);

select column_id, column_name, data_type, data_length 
from user_tab_cols
where table_name = 'EX2_3'  -- table_name은 대문자로 작성
order by column_id;         -- order by : 정렬 default 오름차순(asc : ascending) 생략 가능 

select column_id, column_name, data_type, data_length 
from user_tab_cols
where table_name = 'EX2_3'  -- table_name은 대문자로 작성, where절 -> 검색조건
order by column_id desc;    -- 내림차수능로 정렬 

-- 보통 number를 사용하고, int 크기를 사용할 경우 number(9) 자리수를 언급한다.

CREATE table ex2_4(
    col_flot1 float(32),    -- 2진수 자리수 -> 2진수로 32비트 -> 10자리까지(20억
    col_flot2               -- 최대 유효자리수가 128자리까지
);

select column_id, column_name, data_type, data_length 
from user_tab_cols
where table_name = 'EX2_4'  -- table_name은 대문자로 작성, where절 -> 검색조건
order by column_id;

insert into ex2_4 values(1234567891234, 1234567891234);

select * from ex2_4;

-- 날짜 데이터 타입 : date, timestamp
-- date : 초단위까지 저장, 연도는 4자리까지, default sysdate를 사용
-- timestamp : ms 단위까지 저장, 연도 4자리 이상도 가능, default는 systimestemp를 사용
-- timestamp(9) : 초단위를 ns단위까지 저장 -> 초이하를 몇 자리까지 저장할 것인가를 지정, default 6
create table ex2_5 (
    col_date date,
    col_timestamp timestamp,
    col_date2 date default sysdate,         -- insert시 넣어주지 않아도 default 값으로 초기화가 된다.
    col_timestamp2 timestamp default systimestamp   -- default 값은 DBMS가 insert시 자동으로 넣어준다.
);

insert into ex2_5(col_date, col_timestamp) values( sysdate, systimestamp);
insert into ex2_5(col_date, col_timestamp) values( '2022/07/26' , systimestamp);
select * from ex2_5;
-- sql developer에서 시간에 대한 출력 표기방법은 설정 가능 : 도구 -> 환경설정 -> 데이터베이스 -> NLS

-- 제약조건 : 컬럼에 대하여 어떤 제약을 설정
-- null : 데이터가 없음
-- 테이블의 컬럼을 정의할 때 : null(선택적으로 넣을 수 있다.), not null (필수로 넣어주어야 한다.)
create table ex2_6(
    col_null varchar(10),       -- null : 선택사항 
    col_not_null varchar2(10) not null -- not null : 필수 컬럼 ( 반드시 넣어 주어야 한다. 어떤 값이 존재해야 한다.)
);

insert into ex2_6 (col_not_null) values('abc');     -- null인 컬럼은 안넣어주어도 된다. -> null이 된다.
insert into ex2_6 (col_null) values ('abc');        -- not null에 데이터 넣어주어야 하는데, 안 넣었으므로 에러 -> 필수
insert into ex2_6 values('abc','abc');

select * from ex2_6;

select constraint_name,constraint_type,table_name,search_condition
from user_constraints
where table_name = 'EX2_6';     -- table_name을 소문자로 작성할 경우 못찾는다.

-- 제약조건 : unique -> 유일한, 고유한 -> 중복을 허용하지 않는다. 예) 주민등록번호,학번 -> 인덱싱(검색을 빠르게)
-- 중복해서 값을 넣을 수 없다.
-- 형식 : 컬럼명 데이터타입 unique 또는 constraint 제약조건명 unique(컬럼명) -> (컬럼의 정의와 별개로 작성할 때)
create table ex2_7(
    col_unique_null varchar2(10) unique,        -- unique : 중복을 허용하지 않는다. -> null을 허용 -> 한개만 허용
    col_unique_nnull varchar2(10) unique not null,  -- 중복을 허용하지 않으며, null도 허용하지 않음
    col_unique varchar2(10),
    constraint unique_unique unique (col_unique)  -- 컬럼을 정의한 부분과 별도(분리해서)로 제약조건을 기술할 수 있다.
    -- 제약 조건의 이름을 정해줄 때 사용 -> 나중에 다른데서 제약조건의 이름을 사용이 용이
);

insert into ex2_7 values('aa','aa','aa');
insert into ex2_7 values('aa','aa','aa');   -- 중복해서 데이터를 저장할 수 없으므로 무결성 제약조건에 위배
insert into ex2_7 values('','ab','ab');
insert into ex2_7 values('','ac','ac');
insert into ex2_7 values('ab','ad','ad');   -- 중복 저장은 안되지만, null은 중복 저장할 수 있다.

select * from ex2_7;

-- 기본 키 : unique + not null -> 인덱싱이 되어있음 -> 열을 고유하게 식별해서 열을 검색할 때 많이 사용된다.
-- 테이블을 생성하면 열을 고유하게 식별할 수 있도록 primary key를 정의해 주는 것이 좋다. - 검색을 빠르게 하기 위해서
-- primary key를 정의하지 않으면 열을 찾는데 시간이 오래 소요된다.
-- 테이블의 컬럼 중에 고유하게 식별할 수 있는 컬럼이 없다면 의사 컬럼을 하나 만든다.(게시글 아이디)
-- 형식 : 컬럼명 데이터 타입 PRIMARY KEY 또는 constraint 제약조건명 primary key (컬럼명)
-- 제약조건 이름을 수동으로 주고 싶을 때는 분리해서 기술해 준다.

create table ex2_8(
    col1 varchar2(10) primary key,      -- 자동으로 not null
    col2 varchar2(10) 
);

insert into ex2_8 (col1) values ('abc');
insert into ex2_8 (col1) values ('abc');    -- primary key는 중복 불가
insert into ex2_8 (col1, col2) values ('aaa','abc');
insert into ex2_8 (col1, col2) values ('bbb','abc');

select * from ex2_8;
select * from ex2_8 where col1 = 'abc';     -- 특정 조건으로 검색할 때 검색조건으로 사용하려면 빠르게 검색가능
select * from ex2_8 where col2 = 'abc';     -- 검색 시간도 다르고, 중복을 허용하므로 고유한 열을 검색할 수 없음

create table ex2_82(
    col1 varchar2(10),
    col2 varchar2(10),
    constraint pk_ex282 primary key (col1)  -- 제약조건의 이름을 정의해 줄 때
);
insert into ex2_82 values('abc', 'abc');
select * from ex2_82;

-- 외래 키
create table member1(
    id varchar2(10) primary key,
    name varchar2(15) not null,
    pw varchar2(15) not null
);

create table family1(
    num number primary key,
    mid varchar2(10) not null,
    relation varchar2(15) not null,
    constraint fk_mid foreign key(mid) references member1(id)   -- foreign key 제약조건
);

insert into member1 values ('dkdk','아아아','2323');
insert into family1 values (1,'dkdk','사람');
insert into family1 values (2, 'alal', '사람인듯');     -- member1 테이블에 alal이 없으므로 추가 불가
    // Foreign Key는 member1 테이블에 존재해야 추가할 수 있다.
    // Family1 : 자식 테이블  
select * from family1;

delete from member1 where id='dkdk';    -- 자식 테이블에 관련된 열이 존재할 경우 부모 테이블의 열을 삭제할 수 없음.
-- 부모의 열을 삭제하면, 자식의 열이 존재하기 위한 제약조건을 만족하지 못하게 되므로 삭제가 안된다.
-- 그런데 강제로 해결하는 방법이 3가지 있다.

-- check 제약조건 : 컬럼의 값이 가질 수 잇는 데이터의 범위를 검사(예,0 < value < 10)
-- 형식 : constraint 제약조건명 check(체크조건)
create table ex2_9(
    num1 number constraint check1 check(num1 between 1 and 9),  -- 1 <= num1 <= 9
    gender varchar2(10) constraint check2 check(gender in ('male', 'female'))   -- in : 집합
);

insert into ex2_9 values (7,'male');
insert into ex2_9 values(10, 'female'); -- 제약조건 위반
insert into ex2_9 values(4,'animal');   -- 제약조건 위반
select * from ex2_9;

-- default 제약조건
create table ex2_10(
    col1 varchar2(10) not null,
    col2 number default 0,          -- default 제약조건 : 0으로 초기화(선택사항) -> 컬럼의 값을 넣어주지 않으면 0의 값이 저장된다.
    col3 varchar2(10),
    created date default sysdate    -- default : 선택사항 (넣어줄 필요가 없다)
);
insert into ex2_10 (col1,col3) values('abc','abc');
select * from ex2_10;

-- 테이블 삭제 -> 삭제하면 복구 불가능 -> 주의를 한다.
-- drop table 테이블명;
-- rollback;    -- 삭제된 테이블은 복구가 불가능 
-- 부모 테이블과 자식 테이블이 있을 때 삭제 순서가 존재하낟.
-- 무결성 원칙을 위배하면 안된다. 자식은 부모가 존재해야 의미가 있다.
-- 자식 테이블보다 먼저 부모테이블을 먼저 삭제할 수 없다.
-- 자식 테이블을 삭제한 후에 부모테이블을 삭제한다.

-- 테이블을 생성할 때 자식 테이블보다 부모 테이블이 먼저 생성되어야 한다.

-- 테이블 변경 : 컬럼(추가,삭제,변경), 데이터 타입, 컬럼 이름 

desc ex2_10;    --테이블의 구조를 출력하는 SQL문
-- 컬럼명 변경 : col1 -> col11
alter table ex2_10 rename column col1 to col11;

-- 컬럼 타입 변경
alter table ex2_10 modify col3 varcahr2(30);    -- 10 -> 30 테이블의 컬럼의 크기를 확대
select * from ex2_10;
insert into ex2_10(col11,col3) values('def','aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
alter table ex2_10 modify col3 varchar2(10);    -- 데이터의 크기보다 작게는 줄일 수 없다.(데이터의 변경은 허용하지 않는다.)

-- 컬럼을 추가
alter table ex2_10 add col4 date default sysdate;   -- default 현재시간으로 추가된다. (add한 시간으로)

-- 제약 조건 추가
-- primary key
alter table ex2_10 add constraint pk_ex2_10 primary key (col11);

-- 컬럼삭제
alter table ex2_10 drop column col4;

create table member2(
    id varchar2(10) primary key,
    name varchar2(15) not null,
    pw varchar2(15) not null
);

create table family2(
    num number primary key,
    mid varchar2(10) not null,
    relation varchar2(15) not null
);

-- foreign key 제약조건을 추가
alter table family2 add constraint fk_member2 foreign key (mid) references member2 (id);

-- 제약 조건을 삭제 
alter table ex2_10 drop constraint pk_ex2_10;   -- 제약조건의 이름을 사용해서 삭제
alter table family2 drop constraint fk_member2;

-- 테이블 복사 : 현장에서 문제점을 파악하기 위해 기존 테이블은 유지한채 데이터를 다른 테이블에 복사해서 작업을 할 떄
create table ex2_9_1 as select * from ex2_9; 
select * from ex2_9_1;  -- 복사 데이터를 확인 

-- 2022/07/27 view
-- view 생성
select * from employees;
select * from departments;

select a.employee_id, a.emp_name, a.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id;

-- 뷰: 위의 질의어가 업무를 하는데 많이 사용되므로 하나의 뷰로 정의해서 사용을 한다
-- 뷰: 가상 테이블 -> 물리적으로 테이블이 있는 것은 아니지만 논리적인 테이블이다.
create or replace view emp_dept_v1 as
select a.employee_id, a.emp_name, a.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id;

-- 뷰를 사용해서 세부 작업을 한다.
select * from emp_dept_v1;  -- 마치 새로운 테이블처럼 작업을 할 수 있다.
select employee_id, department_name from emp_dept_v1 where employee_id = 200;

-- 뷰를 삭제
drop view emp_dept_v1;

-- 뷰를 사용해서 update, insert, delete를 하지 않는다.
-- 별도로 물리적인 테이블을 사용하여 작업을 수행한다.

insert into member2 values('qwer','아무나','1234');
insert into family2 values(1, 'qwer','아무거나');

select * from member2;
select * from family2;

select a.id, b.relation
from member2 a, family2 b
where a.id = b.mid;

create or replace view view_member_family as
select a.id, b.relation
from member2 a, family2 b
where a.id = b.mid;

select * from view_member_family;

drop view view_member_family;

-- 인덱스 : 검색을 빠르게 하기 위하여 검색조건에 많이 사용되는 것을 별도의 정렬을 해놓는 것이다.
-- 유일성 여부에 따라 분류 : unique(고유한, 중복불가), non-unique(중복을 허용)
-- 인덱스 를 만드는 컬럼의 수에 따른 분류: 단일 인덱스(컬럼 1개), 결함인덱스(컬럼이 여러개)
-- 사용 빈도가 높은 검색조건에 대하여 인덱스를 만드는 것이 좋음

desc ex2_10;

create unique index ex2_10_ix01 -- col11은 중복을 허용하지 않는다
on ex2_10(col11);

select * from ex2_10;
select * from ex2_10 where col11 = 'abc';   -- where 절을 사용해서 인덱스로 정한 컬럼을 사용해서 검색을 하면 빠르게 검색을 할 수 잇다.
-- 검색을 할 때 내부적으로 인덱스를 사용해서 빠르게 검색이 된다.

-- 테이블 정의 시 컬럼을 unique라고 제약조건을 설정할 수 있다. -> 그러면 내부적으로 unique인덱스가 만들어진다.

-- primary key = unique + not null -> unique 인덱스가 내부적으로 생성된다.
create table ex2_11(
    col1 varhar2(10) unique,    -- unique 제약조건을 설정하면 내부적으로 인덱스가 생성된다.
    col2 number 
);

-- 결합인덱스 : 여러 개의 컬럼을 이용해서 인덱스를 만드는 것
create index ex2_10_ix2
on ex2_10(col11,col2);

-- 인덱스 삭제
drop index ex2_10_ix2;
drop index ex2_10_ix01;

-- Synonym(시노님) -별칭, 동의어, 별명
-- 나 자신의 정보를 숨기고 별칭을 접근할 수 있도록 할 때 사용
-- 유형 : public(별칭을 사용해서 접근) private(사용자, 별칭을 사용해서 접근)
public : dba 만 가능
private : 일반 사용자도 가능
-- Synonym의 생성 및 삭제는 dba 권한이 있어야만 가능
create or replace synonym syn_channel   -- private (public을 생략)
for channels;

-- synonym을 조회
select count (*) from syn_channel;

drop synonym syn_channel;

-- public synonym 생성 : dba 권한이 있어야만 생성
create or replace public synonym syn_channel2 for channels;

drop synonym cyn_channel2;

-- 시퀸스
select * from ex2_8;
delete from ex2_8;  -- 데이터 모두 삭제

create sequence seq_ex28
increment by 1
start with 1
minvalue 1
maxvalue 1000
nocycle -- 최대값이 도달하면 다시 최소값부터 돌아가지 않는다.
nocache;

insert into ex2_8(col1)values(seq_ex28.nextval);    -- insert할 때 시퀀스의 현재값을 가져오고 시퀸스 값이 1씩 증가했다.
-- nextval를 함부로 사용하지 않는다.
select * from ex2_8;

select seq_ex28.currval from dual;  -- 마지막으로 사용된 시퀸스 값이 출력됨

select seq_ex28.nextval from dual;  -- 시퀀스의 현재 값을 가져오지만 시퀀스 값이 증가된다.
-- insert 할 때만 사용된다.

-- 테이블 ex2_8을 삭제할 경우, seq_ex28도 의마가 없으므로 같이 삭제 -> 2개가 같이 연동되어 사용한다.

-- 시퀀스 삭제
drop sequence seq_ex28;

-- 90p 문재1
테이블 : orders
컬럼 : order_id number(12,0)
        order_date date
        order_mode varchar2(8byte)
        customer_id number(6,0)
        order_status number(2,0)
        order_total number(8,2)
        sales_rep_id number(6,0)
        promotion_id number(6,0)
    제약사항 : 기본키는 order_id
    order_mode는 'direct', 'online'만 입력가능
    order_total의 디폴트 값은 0
        
CREATE TABLE orders(
        order_id number(12,0) primary key,
        order_date date,
        order_mode varchar2(8) 
        constraint check_mode check (order_mode in ('direct','online')),
        customer_id number(6),
        order_status number(2),
        order_total number(8,2) default 0,
        sales_rep_id number(6),
        promotion_id number(6)
);
drop table orders;

-- 문제2
CREATE TABLE order_items(
    order_id number(12),
    line_item_id number(3),
    product_id number(3),
    unit_price number(8,2) default 0,
    quantity number(8) default 0,
    constraint pk_order_items primary key(order_id,line_item_id)
);

-- 문제5
create sequence orders_seq
increment by 1
start with 1000
minvalue 1
maxvalue 99999999;


