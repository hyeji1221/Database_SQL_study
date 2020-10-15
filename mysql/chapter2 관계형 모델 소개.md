# **chapter 2 : 관계형 모델 소개**

## 관계형 데이터베이스 (Relational Database)

관계형 데이터베이스는 **테이블**의 모임으로 구성, relation의 집합

**Table** : 고유한 이름을 가지고 있음 (= Relation)

Column = **Attribute** (속성)

- domain을 갖는다 (domain은 속성을 가질 수 있는 값들의 데이터 타입)
- 속성은 값을 가질 수 있으나 더 이상 쪼갤 수 없는 값을 가진다 (atomic, 원자적)
- 속성은 null 값을 가질 수 있다 (null은 값이 알려지지 않을 때, 값이 존재하지 않을때 사용)

Row = **Tuple**

## Relation Schema and Instance

Type definition -> **Relation Schema** -> 고정적임

- R(A1, A2, ... , AN ) -> 정의 방법
- table은 고유한 이름으로 같은 데이터 베이스 안에 **중복된 테이블 이름 존재 불가**
- 한 relation 안에 여러 개의 속성이 있을 때 **속성 값은 중복 불가** (join에 사용되는 경우는 중복 x)

Variable -> **Relation Instance** -> 시간에 따라 변함

- 계속 시스템을 운영하면서 데이터 변경 (추가 or 삭제)

## Database - bad design

여러개의 속성을 하나의 relation을 하나의 relation으로 합치는 경우

1. null 값을 사용한다 -> 되도록 사용하지 않는 것이 good👍
2. 정보의 반복이 발생한다

## Keys 🔑

하나의 tuple을 다른 tuple들로 부터 구별하는 방법 (unique한 속성 찾기)

ex) Student (student number, SSN, email, name)

- Student numer -> ⭕
- SSN (Social security number, 주민등록번호) -> ⭕
- Email address -> ⭕
- Student name -> ❌
- {Student number, Studemt name} -> ⭕ (2개를 같이 사용)

superkey, candidate key, **primary key**, **foreign key**

### Keys - Superkey

어떤 relation이 있을 때 그 안에서 unique한 값을 가지고 있는 속성들의 집합

```sql
 instructor (ID, name, dept_name, salary, SSN)         
            강사 id,      소속학과    연봉  주민번호 `
```

- {ID} -> superkey
- {SSN} -> superkey
- {ID, name} -> superkey
- {ID, SSN} -> superkey
- {SSN, name, dept_name} -> superkey
- {name} -> ❌
- {name, dept_name} -> ❌

### Keys - Candidate Key

A minimal superkey for a relationsuperkey 안에 candidate key가 포함된다❓ minimal superkey : proper subset이 super key가 아닌 것

```sql
instructor (ID, name, dept_name, salary, SSN) 
```

- {ID} -> superkey -> candidate key
- {SSN} -> superkey -> candidate key
- {ID, name} -> superkey
- {ID, SSN} -> superkey
- {SSN, name, dept_name} -> superkey

{ID, name}의 경우 고유하게 만드는데 둘다 사용할 필요가 없기 때문

1. 부분집합을 구한다 : ∅, **{ID}**, **{name}** , {ID, name}

   -> 여기서 공집합, 자기 자신을 제외한 나머지가 proper subset

2. 각각이 superkey 인지 확인한다

   -> 여기서 전부다 superkey가 아니면 **candidate key**이다

   여기서는 name은 superkey가 아니지만 ID가 superkey이므로 candidate key가 아니다

### Keys - Primary Key

데이터베이스 디자이너가 **candidate key가 여러개 있을 때 그 중에 하나를 pk**로 구한다

candidate key가 하나이면 그것이 pk가 된다

super key 안에 candidate key안에 primary key가 있다

**밑줄**로 표기된 것이 pk이다primary key는 table 당 **하나씩**만 갖는다

- 2개가 밑줄 그어 있는 경우는 primary key가 2개가 아닌 2개 합친 것이 primary key

## Keys - Forein key

속성들 중에 다른 relation의 pk인 속성이 있다

방향은 항상 **Fk -> Pk**로 향한다

## Relational Algebra (관계대수)

**Relation에 수행하는 연산의 집합**

- Selection (선택 연산)
- Projection (추출 연산)
- Natural Join (자연 조인)
- Cartesian product (카티션 곱)
- Union (합집합)
- Intersection (교집합)
- Set difference (차집합)

### Selection (선택 연산) - σ

선택 조건을 만족하는 Relation의 tuples을 출력한다사용방법 : **σ condition (realation)**

- condition에 Λ (and), V (or) 사용 가능

### Projection (추출 연산) - Π

relation에서 선택된 attributes를 출력한다사용방법 : **Π attribute-list (relation)**

- ex) Π ID, salary (instructor) => instructor relation에서 교수의 ID와 salary만 필요한 경우

### Natural Join (자연 조인) ▷◁

같은 이름을 가지고 있는 **attributes**에서 두 relations이 같은 값을 가지고 있는 tuples의 쌍을 출력한다

사용방법 : **relation1 ▷◁ relation2**

### Cartisian product (카티션 곱) - x

두 relations부터 가능한 모든 tuple의 쌍을 출력한다

사용방법 : **relation1 x relation2**

### Union (합집합) - ∪

두 relations의 tuples에 대해서 합집합을 수행한다

사용방법 : relation1 ∪ relation2

- ⭐ 두 relation의 속성이 반드시 같아야 한다 ❗

### Intersection (교집합) - ∩

사용방법 : relation1 ∩ relation2

### Set difference (차집합) -

사용방법 : relation1 - relation2

