-- �����ͺ��̽� ��ü
-- ���̺�: �����͸� ��� �ִ� ��ü
-- �� : �ϳ� �̻��� ���̺��� ������ ��ġ ���̺��� ��ó�� ����ϴ� ��ü
-- �ε���: ���̺� �ִ� �����͸� ������ ã�� ���� ��ü
-- �ó��: �����ͺ��̽� ��ü�� ���� ��Ī�� �ο��� ��ü
-- ������: �Ϸù�ȣ ä���� �� �� ���Ǵ� ��ü
-- �Լ�: Ư�� ������ �ϰ� ���� ��ȯ�ϴ� ��ü
-- ���ν���: �Լ��� ��������� ���� ��ȯ������ �ʴ� ��ü
-- ��Ű��: �뵵�� �°� �Լ��� ���ν����� �ϳ��� ���� ���� ��ü

-- ���̺� ����
/* 
CREATE TABLE [��Ű��.]���̺��(
    �÷�1 �÷�1_������Ÿ��   [NULL, NOT NULL],
    �÷�2 �÷�2_������Ÿ��   [NULL, NOT NULL},
...
)[TABLESPACE ���̺� �����̽���};
*/

-- ���� ������ Ÿ��
-- CHAR(ũ��[BYTE|CHAR]): �������� ����, �ִ� 2000byte, ����Ʈ ���� 1byte
-- VARCHAR2(ũ��[BYTE|CHAR]): �������� ����, �ִ� 4000byte, ����Ʈ ���� 1byte
-- NCHAR(ũ��): �������� �����ڵ� ����, �ִ� 2000byte, ����Ʈ ���� 1
-- NVARCHAR2(ũ��): �����⸵ �����ڵ� ����, �ִ� 4000byte, ����Ʈ ���� 1
-- LONG �ִ� 2GB ũ���� �������� ������

-- 2022/07/26
-- ������ Ÿ�� 
-- ���� ������ Ÿ��
/*
- CHAR(10) : ������ ũ�⸦ ������. : �����Ͱ� ������ ������� 10����Ʈ ũ�⸦ ������.
�ִ�� ������ ũ��� 2000����Ʈ
ab -> 10����Ʈ
- VACAHR2(10) : ���� ���ڿ� -> ũ�Ⱑ �������� ���̿� ���� �ִ� 10����Ʈ ����
�ִ� ������ ũ��� 4000����Ʈ
�ٱ�� ������ ���� VARCHAR2�� ���
ab -> 2����Ʈ
- NCAHR(10) : ���������� �����ڵ� ����
�ִ� 2000����Ʈ -> �����ڵ尡 2����Ʈ �̹Ƿ� 4000����Ʈ
- MVARCHAR2(100) : ���� �����ڵ�(UTF-8)
�ִ� 4000
- LONG : 2GB -> VARHCAR2���� �� ū ���ڿ��� ������ ��
    �ڹ��� LONG���� �ٸ���
    
-- ���� ������ Ÿ��
- NUMBER[(p [,s])]
    + p : ��ȿ �ڸ��� ( 1~38 )
    + s : ������ ��ȿ�ڸ��� -> ������ �Ҽ��κ��� �ڸ��� �� (-84 ~ 127)
    * - 0���� ū �ڸ����� ����
    * + 0���� ���� �Ҽ��� �κ�
    * + �Ҽ��� �κи��� ��ȿ�ڸ����� ��Ÿ����.
- ���� number Ÿ���� ��� -> default�� 38�ڸ����̴�. -> �ڹ� Long(��ü)�� ����Ѵ�.
- �ڹ��� int ���·� �����Ϸ��� numbedr(9) : 200000000 = 2* 10E9
- �Ҽ����� �����Ϸ��� number�� ����Ѵ�.

-- ���̺� ����
*/
CREATE TABLE ex2_1(
    column1 char(10),    -- ���� ũ�� ���ڿ� : 10 ����Ʈ
    column2 varchar(10),    -- ���� ũ�� ���ڿ� : �ִ� 10 ����Ʈ
    column3 nvarchar2(10),  -- ���� UTF-8 ���ڿ� 10����Ʈ
    column4 number          -- ���� : 30 �ڸ�
);

-- ���� �߰�
INSERT INTO ex2_1 (column1, column2) VALUES ('abc', 'abc');
INSERT INTO ex2_1 (column1) VALUES ('def');
INSERT INTO ex2_1 (column1, column2, column3, column4 ) VALUES ('asd','qwe','�ѱ�', 10);

SELECT column1, LENGTH(column1) as len1,
       column2, LENGTH(column2) as len2
    FROM ex2_1;
-- ���̺��� �����͸� �˻�
SELECT * FROM ex2_1;

-- ���ο� ���̺� ����
CREATE TABLE ex2_2(
        COLUMN1 VARCHAR2(3),    -- ����Ʈ ���� byte ����, �ִ� ���� 3����Ʈ
        COLUMN2 VARCHAR2(3 byte),   -- �ִ� ���� 3����Ʈ
        COLUMN3 VARCHAR2(3 char)   -- �ѱ� 3�� (6����Ʈ)
);

insert into ex2_2 values ('abc', 'abc', 'abc');    -- ��� ���� �߰��� ��, ���� �����ϴ� �κ��� ��������
insert into ex2_2 values ('abcd', 'abc', 'abc');   -- �ʰ��� �Է� �Ұ��� : �ִ� 3 ����Ʈ�ε� 4����Ʈ�� �߰�
insert into ex2_2 values ('abc', 'abc', 'ȫ�浿');  -- �ѱ� 1�ڿ� ���� 2����Ʈ�� �ش�
insert into ex2_2 values ('abc', 'abc', 'abcdef'); -- ������ �ѱ��� ����
insert into ex2_2 values ('ȫ��', 'abc', 'abc');    -- �ִ밪�� 3�ε� ���� c (�ѱ� 1����Ʈ ���� 3����Ʈ�� �ش�)
insert into ex2_2 values ('ȫ', 'abc', 'abc');      -- �ѱ� 1�ڰ� ���� 3����Ʈ�� �ش�

SELECT * FROM ex2_2;

select column3, length(column3) as len3, length(column3) bytelen from ex2_2;
-- ���� : as Ű���带 ����ϰų� ���� �� �� �ִ�.

CREATE TABLE ex2_3(
    col_int integer,
    col_dec decimal,
    col_num number      -- default 38¥������ ������ �� �ִ�.
);

select column_id, column_name, data_type, data_length 
from user_tab_cols
where table_name = 'EX2_3'  -- table_name�� �빮�ڷ� �ۼ�
order by column_id;         -- order by : ���� default ��������(asc : ascending) ���� ���� 

select column_id, column_name, data_type, data_length 
from user_tab_cols
where table_name = 'EX2_3'  -- table_name�� �빮�ڷ� �ۼ�, where�� -> �˻�����
order by column_id desc;    -- ���������ɷ� ���� 

-- ���� number�� ����ϰ�, int ũ�⸦ ����� ��� number(9) �ڸ����� ����Ѵ�.

CREATE table ex2_4(
    col_flot1 float(32),    -- 2���� �ڸ��� -> 2������ 32��Ʈ -> 10�ڸ�����(20��
    col_flot2               -- �ִ� ��ȿ�ڸ����� 128�ڸ�����
);

select column_id, column_name, data_type, data_length 
from user_tab_cols
where table_name = 'EX2_4'  -- table_name�� �빮�ڷ� �ۼ�, where�� -> �˻�����
order by column_id;

insert into ex2_4 values(1234567891234, 1234567891234);

select * from ex2_4;

-- ��¥ ������ Ÿ�� : date, timestamp
-- date : �ʴ������� ����, ������ 4�ڸ�����, default sysdate�� ���
-- timestamp : ms �������� ����, ���� 4�ڸ� �̻� ����, default�� systimestemp�� ���
-- timestamp(9) : �ʴ����� ns�������� ���� -> �����ϸ� �� �ڸ����� ������ ���ΰ��� ����, default 6
create table ex2_5 (
    col_date date,
    col_timestamp timestamp,
    col_date2 date default sysdate,         -- insert�� �־����� �ʾƵ� default ������ �ʱ�ȭ�� �ȴ�.
    col_timestamp2 timestamp default systimestamp   -- default ���� DBMS�� insert�� �ڵ����� �־��ش�.
);

insert into ex2_5(col_date, col_timestamp) values( sysdate, systimestamp);
insert into ex2_5(col_date, col_timestamp) values( '2022/07/26' , systimestamp);
select * from ex2_5;
-- sql developer���� �ð��� ���� ��� ǥ������ ���� ���� : ���� -> ȯ�漳�� -> �����ͺ��̽� -> NLS

-- �������� : �÷��� ���Ͽ� � ������ ����
-- null : �����Ͱ� ����
-- ���̺��� �÷��� ������ �� : null(���������� ���� �� �ִ�.), not null (�ʼ��� �־��־�� �Ѵ�.)
create table ex2_6(
    col_null varchar(10),       -- null : ���û��� 
    col_not_null varchar2(10) not null -- not null : �ʼ� �÷� ( �ݵ�� �־� �־�� �Ѵ�. � ���� �����ؾ� �Ѵ�.)
);

insert into ex2_6 (col_not_null) values('abc');     -- null�� �÷��� �ȳ־��־ �ȴ�. -> null�� �ȴ�.
insert into ex2_6 (col_null) values ('abc');        -- not null�� ������ �־��־�� �ϴµ�, �� �־����Ƿ� ���� -> �ʼ�
insert into ex2_6 values('abc','abc');

select * from ex2_6;

select constraint_name,constraint_type,table_name,search_condition
from user_constraints
where table_name = 'EX2_6';     -- table_name�� �ҹ��ڷ� �ۼ��� ��� ��ã�´�.

-- �������� : unique -> ������, ������ -> �ߺ��� ������� �ʴ´�. ��) �ֹε�Ϲ�ȣ,�й� -> �ε���(�˻��� ������)
-- �ߺ��ؼ� ���� ���� �� ����.
-- ���� : �÷��� ������Ÿ�� unique �Ǵ� constraint �������Ǹ� unique(�÷���) -> (�÷��� ���ǿ� ������ �ۼ��� ��)
create table ex2_7(
    col_unique_null varchar2(10) unique,        -- unique : �ߺ��� ������� �ʴ´�. -> null�� ��� -> �Ѱ��� ���
    col_unique_nnull varchar2(10) unique not null,  -- �ߺ��� ������� ������, null�� ������� ����
    col_unique varchar2(10),
    constraint unique_unique unique (col_unique)  -- �÷��� ������ �κа� ����(�и��ؼ�)�� ���������� ����� �� �ִ�.
    -- ���� ������ �̸��� ������ �� ��� -> ���߿� �ٸ����� ���������� �̸��� ����� ����
);

insert into ex2_7 values('aa','aa','aa');
insert into ex2_7 values('aa','aa','aa');   -- �ߺ��ؼ� �����͸� ������ �� �����Ƿ� ���Ἲ �������ǿ� ����
insert into ex2_7 values('','ab','ab');
insert into ex2_7 values('','ac','ac');
insert into ex2_7 values('ab','ad','ad');   -- �ߺ� ������ �ȵ�����, null�� �ߺ� ������ �� �ִ�.

select * from ex2_7;

-- �⺻ Ű : unique + not null -> �ε����� �Ǿ����� -> ���� �����ϰ� �ĺ��ؼ� ���� �˻��� �� ���� ���ȴ�.
-- ���̺��� �����ϸ� ���� �����ϰ� �ĺ��� �� �ֵ��� primary key�� ������ �ִ� ���� ����. - �˻��� ������ �ϱ� ���ؼ�
-- primary key�� �������� ������ ���� ã�µ� �ð��� ���� �ҿ�ȴ�.
-- ���̺��� �÷� �߿� �����ϰ� �ĺ��� �� �ִ� �÷��� ���ٸ� �ǻ� �÷��� �ϳ� �����.(�Խñ� ���̵�)
-- ���� : �÷��� ������ Ÿ�� PRIMARY KEY �Ǵ� constraint �������Ǹ� primary key (�÷���)
-- �������� �̸��� �������� �ְ� ���� ���� �и��ؼ� ����� �ش�.

create table ex2_8(
    col1 varchar2(10) primary key,      -- �ڵ����� not null
    col2 varchar2(10) 
);

insert into ex2_8 (col1) values ('abc');
insert into ex2_8 (col1) values ('abc');    -- primary key�� �ߺ� �Ұ�
insert into ex2_8 (col1, col2) values ('aaa','abc');
insert into ex2_8 (col1, col2) values ('bbb','abc');

select * from ex2_8;
select * from ex2_8 where col1 = 'abc';     -- Ư�� �������� �˻��� �� �˻��������� ����Ϸ��� ������ �˻�����
select * from ex2_8 where col2 = 'abc';     -- �˻� �ð��� �ٸ���, �ߺ��� ����ϹǷ� ������ ���� �˻��� �� ����

create table ex2_82(
    col1 varchar2(10),
    col2 varchar2(10),
    constraint pk_ex282 primary key (col1)  -- ���������� �̸��� ������ �� ��
);
insert into ex2_82 values('abc', 'abc');
select * from ex2_82;

-- �ܷ� Ű
create table member1(
    id varchar2(10) primary key,
    name varchar2(15) not null,
    pw varchar2(15) not null
);

create table family1(
    num number primary key,
    mid varchar2(10) not null,
    relation varchar2(15) not null,
    constraint fk_mid foreign key(mid) references member1(id)   -- foreign key ��������
);

insert into member1 values ('dkdk','�ƾƾ�','2323');
insert into family1 values (1,'dkdk','���');
insert into family1 values (2, 'alal', '����ε�');     -- member1 ���̺� alal�� �����Ƿ� �߰� �Ұ�
    // Foreign Key�� member1 ���̺� �����ؾ� �߰��� �� �ִ�.
    // Family1 : �ڽ� ���̺�  
select * from family1;

delete from member1 where id='dkdk';    -- �ڽ� ���̺� ���õ� ���� ������ ��� �θ� ���̺��� ���� ������ �� ����.
-- �θ��� ���� �����ϸ�, �ڽ��� ���� �����ϱ� ���� ���������� �������� ���ϰ� �ǹǷ� ������ �ȵȴ�.
-- �׷��� ������ �ذ��ϴ� ����� 3���� �ִ�.

-- check �������� : �÷��� ���� ���� �� �մ� �������� ������ �˻�(��,0 < value < 10)
-- ���� : constraint �������Ǹ� check(üũ����)
create table ex2_9(
    num1 number constraint check1 check(num1 between 1 and 9),  -- 1 <= num1 <= 9
    gender varchar2(10) constraint check2 check(gender in ('male', 'female'))   -- in : ����
);

insert into ex2_9 values (7,'male');
insert into ex2_9 values(10, 'female'); -- �������� ����
insert into ex2_9 values(4,'animal');   -- �������� ����
select * from ex2_9;

-- default ��������
create table ex2_10(
    col1 varchar2(10) not null,
    col2 number default 0,          -- default �������� : 0���� �ʱ�ȭ(���û���) -> �÷��� ���� �־����� ������ 0�� ���� ����ȴ�.
    col3 varchar2(10),
    created date default sysdate    -- default : ���û��� (�־��� �ʿ䰡 ����)
);
insert into ex2_10 (col1,col3) values('abc','abc');
select * from ex2_10;

-- ���̺� ���� -> �����ϸ� ���� �Ұ��� -> ���Ǹ� �Ѵ�.
-- drop table ���̺��;
-- rollback;    -- ������ ���̺��� ������ �Ұ��� 
-- �θ� ���̺�� �ڽ� ���̺��� ���� �� ���� ������ �����ϳ�.
-- ���Ἲ ��Ģ�� �����ϸ� �ȵȴ�. �ڽ��� �θ� �����ؾ� �ǹ̰� �ִ�.
-- �ڽ� ���̺��� ���� �θ����̺��� ���� ������ �� ����.
-- �ڽ� ���̺��� ������ �Ŀ� �θ����̺��� �����Ѵ�.

-- ���̺��� ������ �� �ڽ� ���̺��� �θ� ���̺��� ���� �����Ǿ�� �Ѵ�.

-- ���̺� ���� : �÷�(�߰�,����,����), ������ Ÿ��, �÷� �̸� 

desc ex2_10;    --���̺��� ������ ����ϴ� SQL��
-- �÷��� ���� : col1 -> col11
alter table ex2_10 rename column col1 to col11;

-- �÷� Ÿ�� ����
alter table ex2_10 modify col3 varcahr2(30);    -- 10 -> 30 ���̺��� �÷��� ũ�⸦ Ȯ��
select * from ex2_10;
insert into ex2_10(col11,col3) values('def','aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
alter table ex2_10 modify col3 varchar2(10);    -- �������� ũ�⺸�� �۰Դ� ���� �� ����.(�������� ������ ������� �ʴ´�.)

-- �÷��� �߰�
alter table ex2_10 add col4 date default sysdate;   -- default ����ð����� �߰��ȴ�. (add�� �ð�����)

-- ���� ���� �߰�
-- primary key
alter table ex2_10 add constraint pk_ex2_10 primary key (col11);

-- �÷�����
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

-- foreign key ���������� �߰�
alter table family2 add constraint fk_member2 foreign key (mid) references member2 (id);

-- ���� ������ ���� 
alter table ex2_10 drop constraint pk_ex2_10;   -- ���������� �̸��� ����ؼ� ����
alter table family2 drop constraint fk_member2;

-- ���̺� ���� : ���忡�� �������� �ľ��ϱ� ���� ���� ���̺��� ������ä �����͸� �ٸ� ���̺� �����ؼ� �۾��� �� ��
create table ex2_9_1 as select * from ex2_9; 
select * from ex2_9_1;  -- ���� �����͸� Ȯ�� 

-- 2022/07/27 view
-- view ����
select * from employees;
select * from departments;

select a.employee_id, a.emp_name, a.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id;

-- ��: ���� ���Ǿ ������ �ϴµ� ���� ���ǹǷ� �ϳ��� ��� �����ؼ� ����� �Ѵ�
-- ��: ���� ���̺� -> ���������� ���̺��� �ִ� ���� �ƴ����� ������ ���̺��̴�.
create or replace view emp_dept_v1 as
select a.employee_id, a.emp_name, a.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id;

-- �並 ����ؼ� ���� �۾��� �Ѵ�.
select * from emp_dept_v1;  -- ��ġ ���ο� ���̺�ó�� �۾��� �� �� �ִ�.
select employee_id, department_name from emp_dept_v1 where employee_id = 200;

-- �並 ����
drop view emp_dept_v1;

-- �並 ����ؼ� update, insert, delete�� ���� �ʴ´�.
-- ������ �������� ���̺��� ����Ͽ� �۾��� �����Ѵ�.

insert into member2 values('qwer','�ƹ���','1234');
insert into family2 values(1, 'qwer','�ƹ��ų�');

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

-- �ε��� : �˻��� ������ �ϱ� ���Ͽ� �˻����ǿ� ���� ���Ǵ� ���� ������ ������ �س��� ���̴�.
-- ���ϼ� ���ο� ���� �з� : unique(������, �ߺ��Ұ�), non-unique(�ߺ��� ���)
-- �ε��� �� ����� �÷��� ���� ���� �з�: ���� �ε���(�÷� 1��), �����ε���(�÷��� ������)
-- ��� �󵵰� ���� �˻����ǿ� ���Ͽ� �ε����� ����� ���� ����

desc ex2_10;

create unique index ex2_10_ix01 -- col11�� �ߺ��� ������� �ʴ´�
on ex2_10(col11);

select * from ex2_10;
select * from ex2_10 where col11 = 'abc';   -- where ���� ����ؼ� �ε����� ���� �÷��� ����ؼ� �˻��� �ϸ� ������ �˻��� �� �� �մ�.
-- �˻��� �� �� ���������� �ε����� ����ؼ� ������ �˻��� �ȴ�.

-- ���̺� ���� �� �÷��� unique��� ���������� ������ �� �ִ�. -> �׷��� ���������� unique�ε����� ���������.

-- primary key = unique + not null -> unique �ε����� ���������� �����ȴ�.
create table ex2_11(
    col1 varhar2(10) unique,    -- unique ���������� �����ϸ� ���������� �ε����� �����ȴ�.
    col2 number 
);

-- �����ε��� : ���� ���� �÷��� �̿��ؼ� �ε����� ����� ��
create index ex2_10_ix2
on ex2_10(col11,col2);

-- �ε��� ����
drop index ex2_10_ix2;
drop index ex2_10_ix01;

-- Synonym(�ó��) -��Ī, ���Ǿ�, ����
-- �� �ڽ��� ������ ����� ��Ī�� ������ �� �ֵ��� �� �� ���
-- ���� : public(��Ī�� ����ؼ� ����) private(�����, ��Ī�� ����ؼ� ����)
public : dba �� ����
private : �Ϲ� ����ڵ� ����
-- Synonym�� ���� �� ������ dba ������ �־�߸� ����
create or replace synonym syn_channel   -- private (public�� ����)
for channels;

-- synonym�� ��ȸ
select count (*) from syn_channel;

drop synonym syn_channel;

-- public synonym ���� : dba ������ �־�߸� ����
create or replace public synonym syn_channel2 for channels;

drop synonym cyn_channel2;

-- ������
select * from ex2_8;
delete from ex2_8;  -- ������ ��� ����

create sequence seq_ex28
increment by 1
start with 1
minvalue 1
maxvalue 1000
nocycle -- �ִ밪�� �����ϸ� �ٽ� �ּҰ����� ���ư��� �ʴ´�.
nocache;

insert into ex2_8(col1)values(seq_ex28.nextval);    -- insert�� �� �������� ���簪�� �������� ������ ���� 1�� �����ߴ�.
-- nextval�� �Ժη� ������� �ʴ´�.
select * from ex2_8;

select seq_ex28.currval from dual;  -- ���������� ���� ������ ���� ��µ�

select seq_ex28.nextval from dual;  -- �������� ���� ���� ���������� ������ ���� �����ȴ�.
-- insert �� ���� ���ȴ�.

-- ���̺� ex2_8�� ������ ���, seq_ex28�� �Ǹ��� �����Ƿ� ���� ���� -> 2���� ���� �����Ǿ� ����Ѵ�.

-- ������ ����
drop sequence seq_ex28;

-- 90p ����1
���̺� : orders
�÷� : order_id number(12,0)
        order_date date
        order_mode varchar2(8byte)
        customer_id number(6,0)
        order_status number(2,0)
        order_total number(8,2)
        sales_rep_id number(6,0)
        promotion_id number(6,0)
    ������� : �⺻Ű�� order_id
    order_mode�� 'direct', 'online'�� �Է°���
    order_total�� ����Ʈ ���� 0
        
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

-- ����2
CREATE TABLE order_items(
    order_id number(12),
    line_item_id number(3),
    product_id number(3),
    unit_price number(8,2) default 0,
    quantity number(8) default 0,
    constraint pk_order_items primary key(order_id,line_item_id)
);

-- ����5
create sequence orders_seq
increment by 1
start with 1000
minvalue 1
maxvalue 99999999;

commit;