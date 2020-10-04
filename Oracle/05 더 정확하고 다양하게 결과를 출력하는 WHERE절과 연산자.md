# 05 더 정확하고 다양하게 결과를 출력하는 WHERE절과 연산자

## 05 -1 필요한 데이터만 쏙 출력하는 WHERE절

## 05-2 여러개 조건식을 사용하는 AND, OR 연산자

조건식의 개수는 사실상 제한이 없다

보통 실무에서 사용하는 SELSECT문은 OR 연산자보다 AND 연산자를 많이 사용하는 경향이 있다

## 05-3 연산자 종류와 활용 방법

### 산술연산자

### 비교 연산자

문자를 대소 비교 연산자로 비교하기

문자열을 대소 비교 연산자로 비교하기

### 등가 비교 연산자

- =
- != 
- <>
- ^=

!=, <>, ^=는 같은 의미

### 논리 부정 연산자

NOT

### IN 연산자

특정 열에 해당하는 조건을 여러 개 지정할 수 있다

```sql
SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'SALEMAN', 'CLERK');
```

NOT IN도 사용 가능하다

### BETWEEN A AND B

열이름 **BETWEEN** 최솟값 **AND** 최댓값

NOT BETWEEN A AND B도 사용 가능

### LIKE 연산자와 와일드 카드

NOT LIKE도 사용 가능

**ESCAPE절**을 사용하면 와일드 카드 기호가 아닌 데이터로서의 문자로 다루는 것이 가능

### IS NULL

IS NOT NULL도 사용가능

### 집합 연산자

**UNION**

출력 열 개수와 자료형이 같아야 한다

**UNION ALL**

중복을 포함

**INTERSECT**

교집합

**MINUS**

차집합, mysql에서는 except

### 연산자 우선순위





