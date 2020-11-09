# Chapter 3 : Introduction to SQL

## Data-definition language (DDL)

- Degining relatoin schema
- Deleting relation
- Modifying relatoin schema

❗ 참고 (따로 찾아본 내용)

**DDL - 데이터 정의어**

데이터베이스를 정의하는 언어를 말하며 **데이터를 생성하거나 수정, 삭제 등 데이터의 전체 골격을 결정**하는 역할의 언어를 말한다

- CREATE : 데이터베이스, 테이블 등을 생성
- ALTER : 테이블을 수정
- DROP : 데이터베이스, 테이블을 삭제
- TRUNCATE : 테이블을 초기화

**DML - 데이터 조작어**

**테이블에 있는 행과 열을 조작하는 언어**로 데이터베이스 사용자가 질의어를 통하여 저장된 데이터를 실질적으로 처리하는데 사용하느 언어이다.

- SELECT :  데이터를 조회
- INSERT : 데이터를 삽입
- UPDATE : 데이터를 수정
- DELETE :  데이터를 삭제

**DLC - 데이터 제어어**

**데이터베이스에 접근하거나 객체에 권한을 주는 등의 역할**을 하는 언어를 말한다

데이터를 제어하는 언어로 데이터의 보안, 무결성, 회복 등을 정의하는데 사용한다

- GRANT, REVOKE, COMMIT, ROLLBACK 등이 있다

:star: **요약**

**DDL**을 통해 데이터 베이스와 테이블을 **생성 및 변경 제거**를 하고

**DML**을 통해 생성된 테이블 내에 있는 데이터들(행과 열)을 **입력, 변경, 수정** 등을 하며

**DCL**을 통해 데이터베이스의 **접속 권한**등을 수정할 수 있다

## Basic Types in SQL

- **char (n)** : 고정길이, 문자열
- **varchar(n)** : 가변길이, 문자열
- **int** : 정수
- **smallint** : 작은 숫자 (정수)
- **numeric (d, p)** : 실수 표현
  + ex ) numeric (7, 3) : _ _ _ _ . _ _ _
- **real, double precision** : 실수

## Create Table Construct

**relation을 정의**할 때 사용한다

```sql
create table r (A1, D1,
                A2, D2,
               	......,
               	AN, DN,   -- attributes
               	(integrity-constraint1), -- Integrity constraints
                ...,
               	(integrity-constraintk));
```

여기서 A는 속성 이름, D는 속성이 가질 수 있는 domain (data type)이다

```sql
-- Example
create table instructor (
				ID char(5),
				name varchar(20),
				dept_name varchar(20),
				salary numeric(8,2));  -- create empty table
```

## Insert Statement

```sql
-- Exmaple
insert into instructor values ('10211', 'Smith', 'Biology', 66000);
```

## Alter Table

기존 table을 변경할 때 사용

- **alter table** r **add** A D : A라는 속성을 relation r에 추가
- **alter table** r **drop** A : 속성 A 제거

## Drop Table

- **drop table** r : 기존에 있었던 table을 삭제 -> 전체가 없어짐 (relation도 제거) 
- **delete from** r : tuple들만 삭제하고 relation r은 유지

## Integrity Constraints

```sql
-- Example
create table instructor (
				ID char(5), --primary key, 이렇게도 정의 가능 (pk가 하나인 경우에만 가능)
				name varchar(20), not null
				dept_name varchar(20),
				salary numeric(8,2),
				primary key (ID),
				foreign key (dept_name) references department(dept_name));
				-- foreign key (...) references R(...) Fk 여러개 지정 가능
```

- **not null**
  + not null로 지정한 속성에 null을 넣으면 error ❗ 
- **primary key** (A1, ..., An)
  + table에 한개만 정의 가능하다
  + not null : pk로 선언된 속성에 null을 넣으면 error ❗ 
  + unique : 중복된 값을 넣으면 error ❗ 
- **Foreign key** (Am, ..., An) **references** r
  + 다른 realation의 pk를 참고하고 있는 속성
  + Fk의 값은 참조하고 있는 pk에 값이 존재해야 한다 -> pk로 먼저 선언된 relation이 존재해야 Fk로 선언 가능하다

## MySQL 실습

**SHOW DATABASES;**

**CREATE DATABASE** db-name;

**desc** table-name; : table의 속성 정보 제공

