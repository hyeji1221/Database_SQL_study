# Basic Query Structure 

```sql
select A1, A2, ... , AN -- 속성들
from r1, r2, ... , rm -- relation 들
where p -- predicate (조건)
```

SQL query의 결과는 항상 relation이다

### Select 

```sql
-- Π ID, salary (instructor)를 SQL로 표현하는 법
select ID, salary
from instructor
```

대소문자 구분하지 않는다

### Select - distinct

```sql
-- instructor에서 dept_name을 추출하는데 중복된 것은 제거
select distinct dept_name
from instructor
```

### Select - all

all은 distinct와 반대 개념으로 중복을 허락한다

all을 쓴것과 안쓴 것은 같은 의미이므로 별로 사용하지 않는다

### Select - *

속성 이름 대신 사용 가능하며 모든 속성을 의미한다

```sql
select *
from instructor
```

### Select - arithmetic expressions

domain이 숫자로 표현되는 속성에 사칙연산 (+, -, *, /)을 사용 가능하다

```sql
select ID, name, salary/12 -- 연봉을 12로 나누므로 월급
from instructor
```

### Where

select, from은 반드시 있어야 하지만 where은 옵션으로 있어도, 없어도 된다

Λ (and), V (or)을 사용 가능하다

```sql
-- σ salary>85000(instructor)와 같은 표현
select *
from instructor
where salary > 85000 
-- ex) where dept_name='Comp.sci.' and salary>70000
```

### From

```sql
select *
from instructor, teaches -- instructor와 teaches의 카티션 곱
```

예를 들어 2개의 ID가 같은 tuple의 쌍만 찾을 경우 -> **join** ❗ ❗ 

### Join

```sql
-- Instructor의 이름과 가르켰던 과목의 course_id 찾기
select name, course_id
from instructor, teaches -- step1 카티션 곱
where instructor.ID = teaches.ID -- step2 카티션 곱에서 ID가 같은것만 찾기
```

### Joins

컴퓨터 과학과에서 개설된 course_id와 semeseter, year, title을 찾기

-> join을 하지 않으면 원하는 정보를 찾을 수 없다

-> semester와 year는 section에만 있고 title은 course에만 있기 때문

=> **정보가 흩어져 있기 때문** -> **cartisian product로 해결**

```sql
select section.course_id, semester, year, title
from section, course  -- cartisian product
where section.course_id = course.course_id and dept_name = 'Comp.Sci.'
```

### Natural Join ▷◁

모든 natural join 형태는 cartisian product로 바꿀 수 있지만 모든 cartisian product는 natural join으로 불가

natural join -> cartisian product  ⭕

cartisian product -> natural join ❌

```sql
-- instructor ▷◁ teaches와 같은 표현
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID -- natural join의 조건

-- 같은 표현
select *
from instructor natural join teaches
```

## Additional Basic Operations

### The Rename Operation - as

결과를 볼 때만 영향을 미치고 table을 처음 정의할 때 만들었던 id, name, salary가 disk에서 변경되는 것은 ❌

```sql
select Id as instructor_id,
		name as instructor_name,
		salary/12 as monthly_salary
from instructor
```

### The Rename Operation - self join

**같은 relation** 안에 있는 **tuple**을 서로 비교할 때 사용

ex ) Finance 교수 중 적어도 한 명보다 연봉이 높은 모든 강사 찾기

```sql
-- 같은 table을 T와 S로 부여 -> join한다 (self-join)
select distinct name
from instructor as T, instructor as S -- (T x S) 결합 가능한 모든 tuple 찾기
where T.salary > S.salary and S.dept_name = 'Finance'
```

71p 참고

### String Operations - like

**percent (%)** : 임의의 문자열

- ex) 'Intro%'
  + Introduction to SQL ⭕
  + An Introduction to SQL ❌ -> 앞에 An이 있기 때문
- '%Comp%'
  + Intro. To Compter Science ⭕
  + Computational Biology ⭕ -> 빈 문자열과 매치

**underscore (_)** : 문자 한 개

- _ _ _ Intro%
  + Intro. To Compter Science ❌ -> Intro 앞에 3개 글자 없기 때문

```sql
select name
from instructor
where name like %in% -- 문자열 in을 포함하는 모든 문자열
```

### Ordering the Display of Tuples - order by

default : 오름차순

```sql
-- 내림차순으로 정렬할 경우
select *
from instructor
order by salary desc
-- order by dept_name, salary 인 경우 dept_name으로 정렬 후 dept_name이 같은 경우 salary로 정렬 
```

:star: **지금까지 배운 옵션들**

select from [where] [order by]

### Where Clause Predicates - between

```sql
select name
from instructor
where salary between 90000 and 100000
-- salary >= 90000 and salary <= 100000도 가능
```

## Set Operations

union (합집합) , intersect (교집합) , except (차집합)

**결과는 항상 중복제거**

중복을 유지하고 싶은 경우 **union all** 사용

```sql
(select course_id
from section
where semester = 'Fail' and year = 2009)
-- union 합집합, 중복 제거
-- union all : 중복을 유지하고 싶은 경우
-- Intersect (as well as 뿐만 아니라)
-- Except (2009년 가을에는 개설되지만 2010년 봄에는 개설되지 않는 과목)
(select course_id
from section
where semester = 'Spring' and year = 2010)
```

## Null Values

- 값을 모를 때
- 값이 존재하지 않을 때

null 연산의 결과는 항상 **null**이다

ex) null > 0  => null

### is null

```sql
select name
from instructor 
where salary is null -- salary 속성이 null인 것만 찾는다
-- is not null로 하면 null이 아닌 것만 찾는다
```

### Three Valued Logic

**OR** : (unknown or true)  = true,  (unknown or false)  = unknown (unknown or unknown)     = unknown 

**AND**: (true and unknown)  = unknown,   (false and unknown)  = false, (unknown and unknown) = unknown 

**NOT**: (not unknown) = unknown

## Aggregate Functions

avg : 평균

min : 최솟값

max : 최댓값

sum : 합

count : 개수를 셀때 사용

```sql
-- avg사용
select avg(salary)
from instructor
where dept_name = 'Comp.Sci.';
```

```sql
-- count 사용
select count(*) -- course relation의 전체 tuple 개수 세기
-- select count(dixtinct Id) 중복 제거할 경우 사용
from course;
```

### Group By

``` sql
select dept_name, avg(salary)
from instructor
group by dept_name; --dept_name이 같은 것끼리 그룹
```

```sql
-- 모호성 발생
select dept_name, ID, avg(salary)
from instructor
group by dept_name;
```

:star: 직계 함수를 제외한 나머지 속성들은 group by에 있어야 한다 

-> 위의 예시에서는 ID가 group by에 없다

null 값을 가지는 tuple은 제외하고 나머지에만 직계 함수가 적용된다

직계 함수의 대상이 되는 속성이 전부 null이면 결과값은 null

### Having Clause

그룹에 적용되는 조건

```sql
select dept_name, avg(salary)
from instructor
group by dept_name
having avg(salary) >42000;
```

**where**은 group by를 하기 전 적용되는 조건 (각각의 tuple에 대해)

**having**은 group by를 한 후 각각의 group에 조건 적용

```sql
-- 배운 내용
select
from
[where]
[order by]
[group by]
[having]
```





 















