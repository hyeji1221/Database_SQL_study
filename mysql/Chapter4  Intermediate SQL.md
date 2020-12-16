# Chapter 4 : Intermediate SQL

## Join Expressions

input으로 2개의 relation -> output relation으로 1개 relation

Cartesian product를 이용할 경우 where절과 함께 사용한다

```sql
select *
from student, takes
where student.ID = takes.ID

select *
from student natural join takes

select *
from student join takes on student.ID = takes.id
-- 3개의 표현 모두 같은 표현이다
```

**:star: join은 정보 손실이 발생할 수 있다**

### Outer Join

**정보 손실을 방지 하기 위한 방법**으로 비어있는 칸은 **null**을 사용한다

지금까지 배운 join은 Inner join으로 Inner은 생략 가능하다

```sql
select *
from course left outer join prereq on course.course_id = prereq.course_id
-- 왼쪽 테이블 정보 유지
```

**left** : 왼쪽 table 정보 유지

**right ** : 오른쪽 table 정보 유지

**full** : 양쪽 table 정보 유지

## Views

**phsyical level -> logical level (realation)-> view level (virtual relation)**

- 위로 갈 수록 high level

- logical level의 relation으로 view를 만들며 view 자체를 가지고 또 다른 view를 만드는 것이 가능하다

중요한 정보를 일반 사용자들이 사용하지 못하게 할 때 사용한다

```sql
create view v as <query expression> -- view 생성 방법
--example
create view faculty as
select ID, name, dept_name
from instructor;
-- view를 만들 때 속성 이름 정의하는 법 (departments_total_salary로)
create view departments_total_salary(dept_name, total_salary) as <query expression>
```

view를 사용할때는 relation처럼 사용 가능하다

자주 사용하는 query를 정의해두면 편하게 사용가능 하다

### Drop View

view 삭제하기

```sql
drop view view_name [,view_name]
-- example
drop view physics_fall_2009
```

## Integrity Constraints

앞의 3장에서는 **not null, primary key, foreign key**를 배웠다

여기서는 unique와 check를 배운다

### Unique Constraint

candidate key 중 pk가 아닌 값에 적용 가능하다

null 값이 허용된다

``` sql
create table department (
	dept_name varchar (20),
	building varchar (15),
	budget numeric (12,2)
	primary key (dept_name),
	unique (building, budget)); -- 2개를 합친 것이 unique
```

### check clause

check (p) -> p는 predicate

check(semester in ('Fall', 'Winter', 'Spring', 'Summber'))

-> semester는 4가지 중 하나만 가져야 한다

### Cascading Actions in Referential Integrity

```sql
-- pk가 포함된 relation
create table department ( 
    dept_name varchar (20), 
    building varchar (15), 
    budget numeric (12,2), primary key (dept_name));    
-- fk가 포함된 relation    
create table instructor ( 
    ID char(5), 
    name varchar(20) not null, 
    dept_name varchar(20), 
    salary numeric(8,2), 
    primary key (ID), 
    foreign key (dept_name) references 
    	department (dept_name) 
    	on delete cascade  -- cascade
    	on update cascade );  -- cascade
```

**on delete casecade와 on update casecade**는 delete와 update를 가능하게 하고 **pk와 fk를 유지**하고 싶을 때 사용한다

 -> pk에 delete를 하면 fk에도 영향, pk에 update를 하면 fk에 영항 (**pk -> fk**)

## SQL Data Types and Schemas

### Built-in Data Types in SQL

**date** : ex) date '2005-7-27'

**time** : ex) time '09:00:30'    time '08:00:30.75'

**timestamp** : ex) timestamp '2005-7-27 09:00:30.75'

### Default Vlues

```sql
...
tot_cred numeric(3,0) default 0,
...
```

위와 같은 경우에 insert into values를 사용하여 tuple을 넣을 때 numeric 속성에 아무런 값도 입력하지 않으면 **null 대신 0**이 들어가게 된다

### User-Defined Types

사용자가 type을 만들 수 있다

```sql
-- Dollars로 numeric(12,2)를 대신하기
create type Dollars as numeric (12,2) final
```

### Domains

```sql
-- person_name이 domain으로 create table에서 type처럼 사용 가능하다
create domain person_name as char(20) not null
```

:star: **not null 제약조건은 꼭 있어야 한다**

