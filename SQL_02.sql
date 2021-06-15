-- dept 테이블 생성
CREATE TABLE dept(
    dep_no      NUMBER(3)                        -- [부서번호] 저장 컬럼 선언. 자료형은 숫자형
    ,dep_name   VARCHAR2(20)    NOT NULL UNIQUE  -- [부서명] 저장 컬럼 선언. 자료형은 문자형. 제약조건 필수입력, 중복제거
    ,loc        VARCHAR2(20)    NOT NULL         -- [부서위치] 저장 컬럼 선언. 자료형은 문자형. 제약조건 필수입력

    ,PRIMARY KEY(dep_no)            -- dep_np 컬럼에 primary key 설정하기. PK / FK 는 밑에 따로 쓴다.
);


/*
-- dept 테이블 제거
DROP TABLE dept;
-- employee 테이블 제거
DROP TABLE employee;
-- customer 테이블 제거
DROP TABLE customer;
-- salary_grade 테이블 제거
DROP TABLE salary_grade;
*/

-- 4개 행 데이터 입력
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2, ~ 컬럼명n) VALUES(입력 데이터, 입력 데이터, ~ 입력 데이터)
INSERT INTO dept(dep_no, dep_name, loc) VALUES(10, '총무부', '서울');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(20, '영업부', '부산');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(30, '전산부', '대전');
INSERT INTO dept VALUES(40, '자재부', '광주');  -- 컬럼 순으로 입력되면 생략 가능
-- 테이블에 입력되는 모든 문자 데이터는 '(싱글 쿼터) 로 감싼다. "(더블 쿼터) 사용 불가!!!
-- INSERT INTO dept VALUES(50, "자재부", "광주");

-- dept 테이블의 모든 컬럼과 모든 행을 검색하기
SELECT * FROM dept;

-- dept 테이블의 dep_no가 10인 행을 검색하기
SELECT * FROM dept WHERE dep_no = 10;

-- employee 테이블 생성. 직원 정보가 저장되는 테이블이다.
CREATE TABLE employee(
    emp_no      NUMBER(3)                       -- [직원번호]가 저장되는 컬럼 선언
    ,emp_name   VARCHAR2(20)    NOT NULL        -- [직원명]이 저장되는 컬럼 선언
    ,dep_no     NUMBER(3)                       -- [소속부서번호]가 저장되는 컬럼 선언
    ,jikup      VARCHAR2(20)    NOT NULL        -- [직급]이 저장되는 컬럼 선언. 제약조건 필수입력
    ,salary     NUMBER(9)       DEFAULT 0       -- [연봉]이 저장되는 컬럼 선언. 제약조건 안주면 0.
                                                -- DEFAULT 데이터는 자료형, 자료형 크기 범위 안에 들어있어야 한다.
    ,hire_date  DATE            DEFAULT SYSDATE -- [입사일]이 저장되는 컬럼 선언. 제약조건 안주면 현재 시간(SYSDATE)
    ,jumun_num  CHAR(13)        NOT NULL UNIQUE -- [주민번호]가 저장되는 컬럼 선언. 제약조건 필주입력, 중복불가
    ,phone      VARCHAR2(15)    NOT NULL        -- [전화번호]가 저장되는 컬럼 선언. 제약조건 필수입력
    ,mgr_emp_no NUMBER(3)                       -- [직속상관직원번호]가 저장되는 컬럼 섬언

    ,PRIMARY KEY(emp_no)                         -- [직원번호] 컬럼에 PK 제약조건 설정
    ,FOREIGN KEY(dep_no) REFERENCES dept(dep_no) -- [소속부서번호] 컬럼에 FK 제약조건 주기.
                                                 -- dept 테이블의 dep_no 컬럼 참조하게 하기
    ,CONSTRAINT employee_mgr_emp_no_fk FOREIGN KEY(mgr_emp_no) REFERENCES employee(emp_no)
      -- [직속상관직원번호] 컬럼에 FK 제약조건 주기. employee 테이블의 emp_no 컬럼 참조하게 하기
      -- CONSTRAINT : 제약 조건 이름 명명, 제약 조건 무력화 시키기 위하여
);


-- employee_mgr_emp_no_fk 라는 이름의 FK 제약조건 끄기. 즉, 제약 조건 임시 무력화
-- 객체의 제약조건(구조) 수정이라 ALTER 사용
ALTER TABLE employee DISABLE CONSTRAINT employee_mgr_emp_no_fk;

-- 오라클 날짜 포맷: 일-영문월-년도
-- 지금 현재 로그인한 계정이 날짜 데이터는 '년-월-일'로 취급하게 하기
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- employee 테이블에 20개 행 입력하기
-- TO_DATE 변환함수 사용하여 날짜 입력
-- INSERT INTO employee VALUES( 1, '홍길동', 10, '사장', 5000, to_date('1980-01-01','YYYY-MM-DD'), '7211271109410', '01099699515', NULL);
INSERT INTO employee VALUES( 1, '홍길동', 10, '사장', 5000, '1980-01-01', '7211271109410', '01099699515', NULL);
INSERT INTO employee VALUES( 2, '한국남', 20, '부장', 3000, '1988-11-01', '6002061841224', '01024948424', 1);
INSERT INTO employee VALUES( 3, '이순신', 20, '과장', 3500, '1989-03-01', '6209172010520', '01026352672', 2);
INSERT INTO employee VALUES( 4, '이미라', 30, '대리', 2503, '1983-04-01', '8409282070226', '01094215694', 17 );
INSERT INTO employee VALUES( 5, '이순라', 20, '사원', 1200, '1990-05-01', '8401041483626', '01028585900', 3 );
INSERT INTO employee VALUES( 6, '공부만', 30, '과장', 4003, '1995-05-01', '8402121563616', '01191338328', 17 );
INSERT INTO employee VALUES( 7, '놀기만', 20, '과장', 2300, '1996-06-01', '8011221713914', '01029463523', 2 );
INSERT INTO employee VALUES( 8, '채송화', 30, '대리', 1703, '1992-06-01', '8105271014112', '01047111052', 17 );
INSERT INTO employee VALUES( 9, '무궁화', 10, '사원', 1100, '1984-08-01', '8303291319116', '01025672300', 12 );
INSERT INTO employee VALUES( 10, '공부해', 30, '사원', 1303, '1988-11-01', '8410031281312', '01027073174', 4 );
INSERT INTO employee VALUES( 11, '류별나', 20, '과장', 1600, '1989-12-01', '8409181463545', '01071628290', 2 );
INSERT INTO employee VALUES( 12, '류명한', 10, '대리', 1800, '1990-10-01', '8207211661117', '01042072622', 20 );
INSERT INTO employee VALUES( 13, '무궁화', 10, '부장', 3000, '1996-11-01', '8603231183011', '01098110955', 1 );
INSERT INTO employee VALUES( 14, '채시라', 20, '사원', 3400, '1993-10-01', '8001172065410', '01044452437', 3 );
INSERT INTO employee VALUES( 15, '최진실', 10, '사원', 2000, '1991-04-01', '8303101932611', '01027491145', 12 );
INSERT INTO employee VALUES( 16, '김유신', 30, '사원', 4000, '1981-04-01', '7912031009014', '01098218448', 4 );
INSERT INTO employee VALUES( 17, '이성계', 30, '부장', 2803, '1984-05-01', '8102261713921', '0165358075', 1 );
INSERT INTO employee VALUES( 18, '강감찬', 30, '사원', 1003, '1986-07-01', '8203121977315', '01033583130', 4 );
INSERT INTO employee VALUES( 19, '임꺽정', 20, '사원', 2200, '1988-04-01', '8701301040111', '01086253078', 7 );
INSERT INTO employee VALUES( 20, '깨똥이', 10, '과장', 4500, '1990-05-01', '8811232452719', '01090084876', 13 );

-- EMPLOYEE 테이블 데이터 삭제
-- DELETE FROM employee;

-- employee 테이블의 모든 컬럼과 모든 행을 검색하기
SELECT * FROM employee;

-- employee_mgr_emp_no_fk 라는 이름의 FK 제약조건 켜기. 즉, 제약 조건 임시 활성화
ALTER TABLE employee ENABLE CONSTRAINT employee_mgr_emp_no_fk;

-- customer 테이블 생성, 고객 정보가 저장되는 테이블이다.
-- 이름 명명 : 너무 추상적인 경우에만 cus_no 식으로 명명한다.
CREATE TABLE customer(
    cus_no      NUMBER(3)                        -- [고객번호]가 저장되는 컬럼 선언
    ,cus_name   VARCHAR2(20)    NOT NULL         -- [고객명]이 저장되는 컬럼 선언. 제약조건 필수 입력
    ,tel_num    VARCHAR2(20)                     -- [전화번호]가 저장되는 컬럼 선언. 제약조건 필수 입력
    ,jumin_num  CHAR(13)        NOT NULL UNIQUE  -- [주민번호]가 저장되는 컬럼 선언. 제약조건 필수 입력, 중복 불가
    ,emp_no     NUMBER(3)                        -- [담당직원번호]가 저장되는 컬럼 선언

    ,PRIMARY KEY(cus_no)                             -- [고객번호] 컬럼에 PK 제약조건 설정
    ,FOREIGN KEY(emp_no) REFERENCES employee(emp_no) -- [담당직원번호] 컬럼에 FK 제약조건 설정.
                                                     -- employee 테이블의 emp_no 컬럼 참조하게 하기
);

-- customer 테이블에 10개 행 데이터 입력
INSERT INTO customer VALUES(1, '류민이', '123-123', '7001131537915', 3);
INSERT INTO customer VALUES(2, '이강민', '343-1454', '6902161627914', 2);
INSERT INTO customer VALUES(3, '이영희', '144-1655', '7503202636215', NULL);
INSERT INTO customer VALUES(4, '김철이', '673-1674', '7704301234567', 4);
INSERT INTO customer VALUES(5, '박류완', '123-1674', '7205211123675', 3);
INSERT INTO customer VALUES(6, '서캔디', '673-1764', '6507252534566', NULL);
INSERT INTO customer VALUES(7, '신똘이', '176-7677', '0006083648614', 7);
INSERT INTO customer VALUES(8, '도쇠돌', '673-6774', '0008041346574', 9);INSERT INTO customer VALUES(9, '권홍이', '767-1234', '7312251234689', 13);INSERT INTO customer VALUES(10, '김안나', '767-1677', '7510152432168', 4);


-- customer 테이블의 모든 컬럼과 모든 행을 검색하기
SELECT * FROM customer;

-- customer 테이블의 모든 컬럼과 모든 행 삭제하기
-- DELETE FROM customer;

-- salary_grade 테이블 생성. 연봉 등급을 관리하는 테이블이다.
CREATE TABLE salary_grade (
    sal_grade_no    NUMBER(2)             -- [연봉등급]이 저장되는 컬럼 선언
    ,min_salary     NUMBER(5)   NOT NULL  -- [최저연봉]이 저장되는 컬럼 선언. 제약조건 필수 입력
    ,max_salary     NUMBER(5)   NOT NULL  -- [최고연봉]이 저장되는 컬럼 선언. 제약조건 필수 입력

    ,PRIMARY KEY(sal_grade_no)            -- [연봉등급] 컬럼에 PK 제약조건 설정
);

-- salary_grade 테이블에 5개 행 데이터 입력
INSERT INTO salary_grade VALUES(1, 8000, 10000);
INSERT INTO salary_grade VALUES(2, 6000, 7999);
INSERT INTO salary_grade VALUES(3, 4000, 5999);
INSERT INTO salary_grade VALUES(4, 2000, 3999);
INSERT INTO salary_grade VALUES(5, 1000, 1999);

-- salary_grade 테이블의 모든 컬럼과 모든 행을 검색하기
SELECT * FROM salary_grade;

-- salary_grade 테이블 모든 컬럼과 모든 행 삭제하기
-- DELETE FROM salary_grade;

-- INSERT 인정
COMMIT;
