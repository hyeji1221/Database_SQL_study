# Chapter 7: Entity-Relationship Model

## Design Phase - Design Process

사용자의 요구사항 -> 요구분석 -> 설계 -> 구현(SQL, 프로그래밍) -> 운영 -> 감시 및 개선 -> 요구분석 ...

## Modeling

데이터베이스는 entity들의 집합, entity 사이의 관계(relationship)로 모델링이 된다.

 => :heavy_exclamation_mark: Entity-Relationship (E-R) model

### Entity

다른 object와 구분되는 실제 object

ex) 각각의 학생들과 각각의 과목, 각각의 학과들은 entity

entity는 속성을 갖는다 -> SQL 용어 중 tuple과 유사

### Relationship

entity 사이의 관계를 표현한다

2,3,4개 표현 가능하다

### Relationship Sets

여러개 relation이 모여 set이 된 형태

ex) 지도 교수와 지도 학생들의 관계에서 강사와 학생이 지도 관계를 시작한 때의 날짜를 가질 수 있다.

### Degree of a Relationship Set

관계에 몇개의 entity set이 참여하는지이다.

- binary relationship : 지금까지 본 형태 (대부분의 관계)
  - 두 개의 entity set을 포함한다

### Attributes

entity는 attribute의 집합을 가지고 표현을 가능하다

Domain은 모든 속성에 지정되어 있어야 한다.

**Attribute types** : Simple and composite attributes

- Simple은 더 이상 쪼갤 수 없다.

- composite는 쪼갤 수 있다, 모델링 단계에서 simple attribute로 바꾸어준다.

#### Attribute types

- simple and composite 
- single-valued and multivalued
- derived attributes : 다른 속성들 값으로부터 유추할 수 있는 속성들 값

## Constraints (제약조건)

### Mapping Cardinality Constraints

relationship에 대해 entity가 관계에 어떻게 참여하는지 나타낸다

**types**

- one to one
- one to many
- many to one
- many to many

### Mapping Cardinalities

사용자의 요구 사항을 분석 하고 분석을 바탕으로 정할 수 있다

super key, candidate key, primary key가 mappint cardinality에 의해 결정된다

### Keys for Relationship Sets

**mapping cardinality를 고려해야 candidate key 결정 가능**

**one to one** : candidate key는 2개 중 한개이고 2개중 아무거나 한개는 pk가 가능하다

-> 2개 다 선택한 것은 minimal하지 않기 때문에 candidate하지 않다

**one to many** :  many 쪽에서 pk를 가져오고 이 key가  candidate key이다.

-> 2개 다 선택한 것은 super key가 된다

**many to many** : 2개 다 선택한 것이 super key, candidate key, pk가 된다 

### Participation Constraints

#### Total participation

관계에 모두 참여

#### Partial participation

관계에 일부만 참여

## E-R Diagrams

rectangles : entity sets (속성은 이 안에)

diamonds : relationship sets

밑줄 : pk

line : 관계에 참여하는 entity set

### Relationship Sets with Attributes

relationship의 속성은 **점선**으로 연결

### Mapping Cardinality Constraints

one : →

many : —

### Participation of an Entity Set in a Relationship Set

**Total participation** : 두 줄로 표현 (double line)

**Partial participation** : 한 줄로 표현

아래에 숫자로도 표현 가능

### Alternative Notation for Cardinality Limits

선 위에 숫자 표시, 는 1보다 큰 숫자

**0..* ** : 최소 0번, 최대 여러번 참여

-> 0번 참여 가능하기 때문에 **partial** 가능

**1..1** : 최소, 최대 모두 1번 참여

-> 무조건 1번 참여하기 때문에 **total**

**1..*** : **total**

### Roles

하나의 entity set이 역할을 바꾸어 2번 참여 가능 -> binary relationship

### Weak Entity Sets

pk를 가지고 있지 않은 entity set

weak entity set은 pk를 갖는 strong entity set을 가져야한다

이때 pk를 갖는 strong entity set을 **Identifying entity set**

그 2개를 연결하는 relationship을 **Identifying relationship** 이라하고 **다이아몬드 2겹**로 표현한다

weak entity set에 있는 **점선**은 pk를 만들 때 같이 사용한다. -> relation schema로 바꿨을 때 Identifying set의 pk와 weak entity set의 점선을 합쳐 weak entity set의 pk로 사용한다.

## Reduction to Relational Schemas

Entity set and relationship set -> relation schemas

### Strong entity set & Simple attribute

### String entity set & Composite attribute

leaf node 속성들만 사용가능하다 -> 더 이상 쪼갤 수 없기 때문

### Multivalued Atrributes

table 분할 발생 -> 2개의 relation schema를 만든다

**1 : 모든 속성을 포함하지만 multi-valued attribute는 제외**

**2 : pk와 multi-valued attribute를 합친 것** -> 합친 것이 2번째 relation의 pk

#### 최적화 (Optimization)

만약 1번에 multi-valued attribute를 제외하니 하나의 속성(pk)만 나오면 굳이 2개로 나눌 필요가 없다 -> 1번 제거 가능

### Representation of Weak Entity Sets

1. Identifying entity set으로 부터 pk를 빌려온다
2. 기존의 것을 합쳐서 포함시킨다
3. pk는 빌려온 pk와 partial key를 합친 것이다
4. 빌려온 pk는 FK로 참조해야한다

### Representing Relationship Sets

1. 관계에 참여하고 있는 entity set의 pk를 가져온다
2. 가지고 있던 속성도 포함한다
3. 가지고 온 pk는 fk에 해당한다
4. mapping cardinality를 이용해 pk를 지정한다

### Redundancy of Schemas (중복된 schemas 제거)

weak entity set이 있을 때 발생 가능 -> 항상은 x

**이름만 다를 뿐 속성이 같으면 둘 중에 하나 제거 가능 (relationship)**

-> 제거 후 사라진 관계를 **many**쪽에 추가해주어야 한다.

필요없는 schema 제거는 가능하지만 정보는 유지되어야 한다

- **mapping cardinality가 many to one 또는 one to many여야 한다**
- **many 쪽 participation이 total 이어야 한다.** -> partial이면 null값이 들어갈 수 있다









 

 