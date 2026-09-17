## ai-database-2026

AI에이전트 개발자 데이터베이스 리포지토

## 1일차

### PostgreSQL 개요

데이터베이스 . 데이터를 한군데에서 관리하는 목적의 시스템

줄여서 Postgre,Postgres 라고 통칭. **관계형** 데이터베이스.

`SQL`을 통해서 테이터를 저장, 수정, 삭제, 조회 할수있는 시스템

- 기타 관계형 데이터베이스
  - Oracle
  - MySQL / MariaDB
  - SQL Server

위 대부분 상용소프트웨어(비용을 지불하는) , Postgre는 오픈소스 System. 라이선스 비용 X

### DB의 특징

- 데이터 무결성
- 데이터 안정성
- 데이터 동시성
- 표준 SQL 지원
- 확장성

### PostgreSQL 설치

#### 기본설치

- 자신의 OS에 직접 설치하는 방법
- postgresql-18.6-3-windows-x64.exe

![](assets/20260915_143300_image.png)

- Superuser 아이디 - postgres 패스워드 지정

![](assets/20260915_143314_image.png)

- port 5432 기억할것

### DBeaver 설치

GUI DB 관리 실행 툴

- https://dbeaver.io/download/
- 생략

### DB 접속

1. DBeaver 실행
2. 새 데이터베이스 연결 클릭 (PostgreQL 클릭)

![](assets/20260915_133339_image.png)

3. 데이터베이스 설정 입력

![](assets/20260915_133307_image.png)

4. Test Connection 클릭 Driver 다운로드 후

![](assets/20260915_133221_image.png)

5. 정상 접속 확인 후 완료 클릭

#### Docker 개요

- 환경 의존성 문제를 해결한 컨테이너 기술 솔루션.
- 가상 환경상 프로그램을 실행하게 만듬
- 컨테이너 - OS , 라이브러리 , 설정 등 하나의 패키지로 만들어진 이미지
- 기본 Docker 실행파일 -> Docker Desktop 윈도우에서 Docker를 편하게 사용하도록

#### Docker Desktop 설치

- https://docs.docker.com/desktop/setup/install/windows-install/
- 윈도우 버전 다운로드 후 설치
- Close and Restart 이후
- WSL(Window Subsystem for Linux) 추가 설치

![](assets/20260915_143359_image.png)

![](assets/20260915_143406_image.png)

- 설치완료 후 화면
- 사용자 user 생성 비밀번호 입력

![](assets/20260915_172312_image.png)

### PostgreSQL 이미지 다운로드

- 이미지 : 도커 리포지토리에 미리 만들어놓은 시스템 패키지
- 컨테이너 : 나의 도커에서 미리 다운로드 받은 이미지를 동작시킨 시스템

##### 도커 명령어 기본

```bash
docker --version
```

- 설치된 도커 확인

##### 도커에서 PostgreSQL 이미지 다운로드

```bash
docker pull postgres:latest
```

- Docker Desktop 전체 검색에서 pull(다운로드)

### 컨테이너 실행

#### 도커 명렁어로 실행

- 여러 옵션으로 실행을 해야하므로 거의 대부분 명령어로 실행

```bash
docker run --name my-postgres -e POSTGRES_PASSWORD=123456 -p 25432:5432 -d postgres:latest
```

### DBeaver에서 접속

그림생략

## DB 기본사용법

#### Postgres 기본구조

![](assets/20260915_142852_image.png)

- ai_db - 데이터베이스(프로젝트 전체공간)
- Schemas - 프로젝트 폴더
- Tables - 실제 데이터를 담는 표

#### DB 생성

- SQL 편집기 클릭
- 새이름으로 저장 , *.sql로 저장
- ai_db 명칭의 새 데이터베이스 생성

```sql
create database ai_db;
```

- Ctrl + Enter로 쿼리 실행
- DB 접속 정보에서 Show All database를 체크하고 재접속
- 데이터베이스 생성확인

#### 테이블 생성

- 데이터베이스 스키마를 사용할 데이터베이스로 반드시 선택

![](assets/20260915_150550_image.png)

- 아래의 코드 작성

```sql
-- 테이블 생성
create table students (
	id int generated always as identity primary key, -- 학생 구분값 자동증가
	name varchar(50) not null, -- 이름
	age int, -- 나이
	email varchar(100), -- 이메일
	created_at timestamp default current_timestamp -- 현재 작성된 일자 
);
```

- Ctrl + Enter 실행

![](assets/20260915_150751_image.png)

- 실행결과

#### 데이터 생성

- insert 쿼리 작성

```sql
-- 데이터 삽입(INSERT)
insert into public.students (name,age,email)
values ('홍길동',20,'honggd@example.com');

insert into public.students (name,age,email)
values ('김철수',21,'kimkim@gmail.com'),
		('김영희',27,'0hee@gmail.com'),
		('이동규',35,'dong92@gmail.com'),
		('임성준',35,'wood@gmail.com');

```

- select 쿼리 작성 - 난이도가 올라감

```sql
-- 데이터 확인(SELECT)
select * from public.students s ;
```

- update 쿼리 작성

```sql
-- 데이터 수정(UPDATE)
update students set 
		email = 'hoggd@kaka.com'
where id = 1;
```

- delete 쿼리 작성

```sql
-- 데이터 삭제(DELETE)
delete from students 
where name = '홍길동';
```

#### Postgres 기본타입


| 데이터 타입 | 설명               | 예제                    |
| ----------- | ------------------ | ----------------------- |
| INT         | 정수               | 10,25,-9                |
| BIGINT      | 큰정수             | 100000000000            |
| NUMERIC     | 정확한 소수        | 120000.56               |
| VARCHAR(n)  | 길이 제한 문자열   | '홍길동'                |
| TEXT        | 긴 문자열(대략 2G) | 뉴스 게시물 논문        |
| BOOLEAN     | 참 또는 거짓       | ture , false            |
| DATE        | 날짜               | 2026-09-15              |
| TIMESTAMP   | 일자(날짜와 시간)  | 2026-09-15 16:00:20.456 |
| JSONB       | JSON 데이터        | {"name" : "홍길동}      |

## 2일차

### SQL 기본

데이터베이스 내용에서 가장 기본적인 문법 CRUD

- SQL : Structured Query Language (구조화된 질의 언어)
- 쿼리로 통칭

### CRUD 정의

데이터 **처리의 기본 동작** 네 가지


| 구분       | 의미              | 쿼리 명령어 |
| :--------- | ----------------- | ----------- |
| **C**REATE | 데이터 생성(삽입) | `INSERT`    |
| **R**EAD   | 데이터 읽기(조회) | `SELECT`    |
| **U**PDATE | 데이터 수정(변경) | `UPDATE`    |
| **D**ELETE | 데이터 삭제       | `DELETE`    |

- 학생 관리 프로그램을 만든다고 가정하면,
  - 학생을 등록
  - 학생 목록 조회 / 특정 학생 내용 조회
  - 학생 정보 수정
  - 학생 정보 삭제

##### 데이터 생성

- 항상 SELECT 쿼리로 확인하기
- INSERT 쿼리로 데이터 추가

```sql
-- 학생 정보 추가 쿼리
-- 쿼리문법 문자열 무조건 ''
insert into students (name , age , email)
values ('홍길동', 20, 'hong@example.com');

-- 컬럼 순서 변경
insert into  students (age, email, name)
values (35, 'DG92@kakao.com' , '이동규');

-- 여러 데이터 추가
insert into students (name , age , email)
values ('홍길순', 20, 'hong1@example.com'),
	('홍길림', 25, 'hong124@example.com'),
	('홍길홍', 54, 'hong1125@example.com');
```

##### 데이터 기본 조회

- SELECT 쿼리로 조회 -[소스](./day02/practise02.sql)
- 처음에는 간단하지만 , 뒤로갈수록 어려워짐

```sql
-- 특정 컬럼만 조회
select s."name" , s.age from students s;

-- 필터링! 필요한 데이터만 조회
select *from students s 
 where s.age < 30;
```

- 정렬

  - `ASC`ending : 오름차순
  - `DESC`ending : 내림차순
- Limit - 필요갯수 만큼 조회

##### 데이터 수정

- UPDATE 쿼리로 수정 -[소스](./day02/practise03.sql)
- UPDATE 쿼리 실행시 WHERE 절 없이 실행 주의 할 것!!

![](assets/20260916_121456_image.png)

##### 데이터 삭제

- DELETE 쿼리로 삭제
- DELETE 쿼리 실행 시도 WHERE 절 없이 실행 주의 할 것!!
- 삭제도 UPDATE와 동일한 경고메세지 창 표시됨

##### 테이블 삭제

- DELETE는 데이터 삭제 , DROP은 테이블 자체 삭제

#### 테이블 생성

테이블 생성 쿼리

```sql
CREATE TABLE students (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- 기본키(PK) - 중복안되고 NOT NULL
    name VARCHAR(50) NOT NULL, -- 이름은 NULL이 될수 없다.
    age INT, -- 나이는 NULL
    email VARCHAR(100), --이메일 NULL
    major VARCHAR(50), -- 전공 NULL
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- NULL이 들어갈수 있음
);
```

#### NULL

- 값이 없다는 뜻 , 숫자 0이나 빈 문자열('')와 다른 의미 ' '과도 다름

##### NULL 사용 쿼리

```sql
-- 데이터 추가
insert  into students (name, age, email, major)
values ('홍길동', 20, 'hong@example.com','컴퓨터공학');

-- 전공을 null 집어 넣음
insert  into students (name, age, email, major)
values ('성유고', 21, 'wood@example.com', null);

-- 나이와 전공에 null 집어넣음
insert into students (name , age, email, major)
values ('성미나', null , 'mina@example.com', null );

insert into students (name)
values ('최민식');
```

![](assets/20260916_145221_image.png)

NULL 조회 쿼리

- `where 컬럼 is null / is not null`

### 테이블 설계

- 일반적으로 DB설계 , 테이블 설계 통칭

### 필요 개념

- 테이블 설계 - 논리적 테이블 설계 , 물리적 테이블 설계
- 컬럼과 데이터 타입 선택
- 기본키(PK) / 외래키(FK) 제약조건
- NOT NULL , UNIQUE , CHECK 제약조건
- DEFAULT 제약조건
- 테이블 관계

학생과 과목 수강 관리 테이블 설계

#### 테이블 설계?

데이터를 어떤 테이블에 어떤 컬럼에 어떠한 관계를 가지고 저장할지 규정하는 작업

- 학생정보
  - 이름
  - 나이
  - 이메일
  - 전공
  - 수강 과목
  - 담당강사
  - 수강 신청일

![](assets/20260916_173405_image.png)

- 엑셀에서는 데이터를 제대로 관리하기 힘들다

#### 좋은 테이블 설계

- 같은 데이터가 불필요하게 중복되지 않게 한다
- 한 테이블은 하나의 주제를 가진다
- 각 행(row)을 구분할 수 있는 기본키(PK)를 가진다
- 테이블 간의 관계가 외래키(FK)로 연결한다
- 잘못된 데이터가 들어가지 않도록 제약조건을 사용한다
- 조회 , 수정이 이해하기 쉬운 구조여야 한다

#### 학생 테이블 컬럼 데이터타입 선택


| **구분**             | **설명**                   | **데이터타입**              |  |
| -------------------- | -------------------------- | --------------------------- | - |
| 학생번호`id`         | 학생을 구분, 반드시 필요   | `INT` , BIGINT , NUMERIC 중 |  |
| 학생이름`name`       | 문자열로 추가, 반드시 입력 | `VARCHAR(50)`,TEXT 중       |  |
| 이메일`email`        | 문자열, 선택으로 입력      | `VARCHAR(200)`,TEXT         |  |
| 나이`age`            | 숫자,150살 이하로만 입력   | `INT`...                    |  |
| 전공`major`          | 문자열 ,                   | `VARCHAR(50)`,TEXT          |  |
| 등록일자`created_at` | 학생 정보를 입력한 일시    | DATE ,`TIMESTAMP` 중        |  |

- 정확한 숫자는 numeric , 긴 글은 text , 날짜만 필요하면 date, 참/거짓은 boolean

#### 제약 조건

##### 1.기본키

테이블에서 각 행(row) 구분하는 대표값 . Primarly Key(PK) - **Unique에 Not Null**

- 중복 불가!
- 비어있을 수 없다!
- 한 행을 대표
- 다른 테이블에서 참조한다

PostgreSQL은 `generated always as identity` 숫자 타입의 자동증가 , `primary key`가 기본키를 지정한다.

```sql
id int generated always as identity primary key
```

MySQL에서 auto_increment, Oracle에서 identity로 문법이 다름.

##### 2.외래키

다른 테이블의 기본키를 참조하는 컬럼. Foreign Key(FK)

```plaintext

Students(학생)
- id : 학생아이디 PK
- name : 학생이름

Enrollments(수강)
- id : 수강아이디 PK
- students_id : 학생아이디 FK
- course_name : 수강명

```

![](https://github.com/hugoMGSung/ai-database-2026/raw/main/assets/20260916_171157_image.png)

```sql
-- 수강 테이블 생성쿼리
create table enrollments (
	id int generated always as identity primary key,
	students_id int not null, -- 수강하는 학생이 없으면 안됨
	course_name varchar(100) not null,  -- 과목명 없으면 안됨
	enrolled_at timestamp default current_timestamp,
	constraint fk_enrollments_students
		foreign key (students_id)
		references students(id)
);
```

## 3일차

### 추가 쿼리

- 테이블 수정 쿼리 - 이미 만들어진 상태의 테이블을 수정하는 쿼리

```sql
-- 테이블 컬럼 사이즈 수정
alter table students 
alter column email type varchar(100);
```

- 이외 제약조건 수정 , 이름 수정 , 불필요한 컬럼 삭제 등 수정 쿼리 작업

### 제약조건

#### PK/FK 관계

![](assets/20260917_094757_image.png)

- students 부모 테이블 - enrollments 자식 테이블

#### NOT NULL 제약조건

- 해당 컬럼은 반드시 값이 들어가야 함

```pgsql
name varchar(50) not null
```

- 아래의 쿼리는 오류가 발생함

```sql
-- 데이터 삽입
insert into students (age,major)
values (23,'경영학과');
```

![](assets/20260917_102559_image.png)

students 테이블에 name은 not-null 제약조건으로 반드시 입력해야하는데 현재 없기 때문에 오류

- 이전에 생성된 컬럼을 NOT NULL로 변경하는 쿼리

```sql
ALTER TABLE public.students ALTER COLUMN email SET NOT NULL;
```

- 오류 화면

![](assets/20260917_102932_image.png)

- NOT NULL 로 변경 불가할때 생기는 오류 화면
- 이전 테이블에 새 컬럼 추가할때 NOT NULL 로만은 생성 불가 . NULL로는 생성 가능

#### UNIQUE 제약 조건

- 중복이 허용되지 않는 제약조건
- 보통 이메일이 다른 사용자와 중복은 허용하지 않으나 , 내 이메일은 다른 걸로 변경가능

```pgsql
ALTER TABLE public.students ADD CONSTRAINT uk_students_email UNIQUE (email);

```

![](assets/20260917_104720_image.png)

#### CHECK 제약조건

- 값이 특정 조건을 만족해야만 저장되는 제약조건
  - 초등학교 학년 : 1~6
  - 대학교 학년 : 1~4
  - 나이 : 0세 이상 , 200세 이하
  - 금액 : 1000원 이상
- INT 타입은 - 21억 ~ 21억까지 수를 저장 . 모두 허용하면 학년에 음수나 0, 1~4 이상의 다른 수 입력 가능
- 이를 방지해서 정확한 데이터만 입력

```pgsql
-- 학년컬럼추가
ALTER TABLE public.students ADD grade int NULL;

```

- 체크 제약조건 추가

```pgsql
ALTER TABLE public.students ADD CONSTRAINT ck_students_grade CHECK (grade>0 and grade <= 4);
```

#### DEFAULT 제약조건

- 값을 입력하지 않으면자동으로 들어가는 기본값

```pgsql
stock int default 0
created_at timestamp default current_timestamp
```

- 수정쿼리

```pgsql
ALTER TABLE public.products ALTER COLUMN category SET DEFAULT '미정';
```

### 테이블 모델링

관계형 DB에는 테이블간 관계에 몇 가지 관계성이 존재


| 관게   | 설명                                            | 예시                     |
| ------ | ----------------------------------------------- | ------------------------ |
| 일대다 | 부모 테이블 한 행이 자식 테이블 여러행과 연결   | 학생과 수강신청 관계     |
| 일대일 | 테이블 한 행이 자식 테이블 한 행과 연결         | 사용자와 사용자 상세정보 |
| 다대다 | 부모 테이블 여러 행이 자식 테이블 여러행과 연결 | 학생과 과목              |

- 다대다 관계는 DB에서 구현 불가. 일대다 / 일대다 관계로 분리해서 구현

![](assets/20260917_121723_image.png)

- 학생 한명은 여러 과목을 수강할 수 있음
- 과목 하나에는 여러 학생이 수강할 수 있음
- 학생 테이블 주요정보
  - 이름, 이메일, 나이, 전공
- 과목 테이블 주요정보
  - 타이틀, 교강사, 시수
- 수강 신청 주요정보
  - 수강 학생정보 구분값, 과목 정보 구분값


#### 모델링 툴

- ERD(Entity Relationship Diagram) 모델링
- https://www.erdcloud.com/


![](assets/20260917_150858_image.png)

- 학생 과목 수강관리 테이블 ERD


### JOIN

관계형 데이터베이스에서 여러개로 나눈 테이블의 정보를 하나로 합쳐서 조회하는 것


### 트랜잭션

- 커밋, 롤백
