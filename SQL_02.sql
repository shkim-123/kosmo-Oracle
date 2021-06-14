-- DEPT 테이블 생성
CREATE TABLE dept(
    dep_no      NUMBER(3)
    ,dep_name   VARCHAR2(20)    NOT NULL UNIQUE
    ,loc        VARCHAR2(20)    NOT NULL
    ,PRIMARY KEY(dep_no)    -- PK / FK 는 밑에 따로 쓴다.
);

-- DEPT 테이블의 모든 컬럼 검색
SELECT * FROM dept;

-- 테이블 객체 삭제
DROP TABLE dept;

-- 데이터 입력
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2, ~ 컬럼명n) VALUES(입력 데이터, 입력 데이터, ~ 입력 데이터)
INSERT INTO dept(dep_no, dep_name, loc) VALUES(10, '총무부', '서울');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(20, '영업부', '부산');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(30, '전산부', '대전');
INSERT INTO dept VALUES(40, '자재부', '광주');  -- 컬럼 순으로 입력되면 생략 가능

-- INSERT 인정
COMMIT;

-- EMPLOYEE 테이블 생성
CREATE TABLE employee(
    emp_no      NUMBER(3)
    ,emp_name   VARCHAR2(20)    NOT NULL
    ,dep_no     NUMBER(3)
    ,jikup      VARCHAR2(20)    NOT NULL
    ,salary     NUMBER(9)       DEFAULT 0
    ,hire_date  DATE            DEFAULT SYSDATE   -- SYSDATE : 현재 시간
    ,jumun_num  CHAR(13)        NOT NULL UNIQUE
    ,phone      VARCHAR2(20)    NOT NULL
    ,mgr_emp_no NUMBER(2)

    ,PRIMARY KEY(emp_no)
    ,FOREIGN KEY(dep_no) REFERENCES dept(dep_no)
    ,CONSTRAINT employee_mgr_emp_no_fk FOREIGN KEY(mgr_emp_no) REFERENCES employee(emp_no)
      -- CONSTRAINT : 제약 조건 이름 명명, 제약 조건 무력화 시키기 위하여
);

SELECT * FROM employee;

-- 오라클 날짜 포맷: 일-영문월-년도
-- 날짜 데이터는 '년-월-일'로 입력 가능하게 하기
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- FK 제약조건 끄기
ALTER TABLE employee DISABLE CONSTRAINT employee_mgr_emp_no_fk;

-- TO_DATE 변환함수 사용하여 날짜 입력
INSERT INTO employee VALUES( 1, '홍길동', 10, '사장', 5000, to_date('1980-01-01','YYYY-MM-DD'), '7211271109410', '01099699515', NULL);

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
DELETE FROM employee;

-- FK 제약조건 켜기
ALTER TABLE employee DISABLE CONSTRAINT employee_mgr_emp_no_fk;
