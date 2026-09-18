-- UPDATE
select *from  students s ;

-- 홍길순의 나이를 변경
update students set 
	   age = 60;
where name ='홍길순';  		
	   
-- 이러지 마세요!
update students set 
	   age = 60;

-- id 11번 삭제
delete from students
 where id =21;

-- 이러면 큰일나요!
delete from students;

-- 논외 : 테이블 삭제
drop table students ;

-- 테이블 생성

CREATE TABLE students (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- 기본키(PK) - 중복안되고 NOT NULL
    name VARCHAR(50) NOT NULL, -- 이름은 NULL이 될수 없다.
    age INT, -- 나이는 NULL
    email VARCHAR(100), --이메일 NULL
    major VARCHAR(50), -- 전공 NULL
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- NULL이 들어갈수 있음
);

-- 데이터 조회
select *from students s ;

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

insert into students (name , age, email, major)
values (null, null , 'mina@example.com', null );

insert into students (name , age, email)
values ('애슐리', 26 , 'ah@example.com');


-- 이메일을 입력하지않은 사용자를 조회
select *from students s 
 where s.email is null; -- where s.email = null; 는 조회불가   

 select *from students s 
 where s.major is not null;
 
 select *from  students s 
 where s.name != '성미나';  -- != 성미나 가 아닌 이름 조회
 
