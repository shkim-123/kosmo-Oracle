-- SELECT문: SELECT 컬럼명 FROM 테이블명;
SELECT
        emp_no
        , emp_name
        , dep_no
        , jikup
        , salary
        , hire_date
        , jumin_num
        , phone
        , mgr_emp_no
FROM
        employee;

-- * 모든 컬럼 검색, 순서는 CREATE 순으로 출력
SELECT * FROM employee;

-- 보고 싶은 컬럼만 보고 싶은 경우
SELECT
        emp_no
        , emp_name
        , jikup
        , salary
        , hire_date
FROM
        employee;


-- ALIAS(별칭) 사용, "(더블 쿼트) 사용★★
SELECT
        emp_no            AS "사원번호"
        , emp_name           "직원명"   -- AS 생략 가능
        , jikup           AS "직급"
        , salary||'만원'  AS "연봉"     -- ||'' 싱글 쿼터 데이터를 붙여서 출력
                                        -- 주의! + 사용 불가, '(싱글 쿼터) 사용 <- 문자 데이터이기 떄문에
        , hire_date           입사일    -- AS, 공백 없을 경우 "(더블 쿼터) 생략 가능
FROM
        employee;

-- 세금은 연봉의 12% 인 경우
SELECT
        emp_name                AS "직원명"
        , jikup                 AS "직급"
        , salary                AS "연봉"
        , salary*0.12||'만원'   AS "세금"   -- 컬럼의 자료형이 NUMBER인 경우 연산이 가능하다.
        , salary*0.88||'만원'   AS "실수령액"
FROM
        employee;

-- 직급 중복 제거
SELECT DISTINCT jikup FROM employee;   -- DISTINCT 중복 제거
SELECT DISTINCT(jikup) FROM employee;  -- DISTINCT()
SELECT UNIQUE jikup FROM employee;     -- UNIQUE
SELECT UNIQUE(jikup) FROM employee;    -- UNIQUE()

-- 부서번호, 직급을 중복 없이 검색
SELECT DISTINCT dep_no, jikup FROM employee;  -- DISTINCT 컬럼명, 컬럼명 .. 중복 없이 검색된다
-- SELECT DISTINCT(dep_no, jikup) FROM employee;   -- 에러
SELECT UNIQUE dep_no, jikup FROM employee;

-- 연봉이 3000 이상인 직원 검색
-- 구조식 언어
SELECT * FROM employee WHERE salary >= 3000;   -- WHERE문에 조건 입력
                                               -- 행을 걸러내는 키워드

-- 연봉 오름차순 검색
SELECT * FROM employee ORDER BY salary ASC; -- ORDER BY문으로 정렬
SELECT * FROM employee ORDER BY salary;     -- ASC : 오름차순(기본값), DESC : 내림차순
                                            -- 행의 순서를 바꿀때 쓰는 키워드
SELECT * FROM employee ORDER BY 5;          -- SELECT문 컬럼명의 위치 번호를 쓰는 경우

-- 연봉 내림차순 검색
SELECT * FROM employee ORDER BY salary DESC;
SELECT * FROM employee ORDER BY 5 DESC;

-- 부서번호 오름차순, 연봉 내림차순
SELECT * FROM employee ORDER BY dep_no ASC, salary DESC;  -- 다중 정렬
SELECT * FROM employee ORDER BY dep_no, salary DESC;      -- ASC 생략 가능!!

-- 직급이 높은 순서 나열
SELECT * FROM employee ORDER BY jikup ASC;
SELECT * FROM employee ORDER BY jikup DESC;
-- 위 답은 모두 잘못된것임
-- 직급 순서는 인간이 생각하는 기준이지 오라클의 단순한 정렬개념이하고는 다르다.
-- 추후 조건문을 써서 정렬의 기준을 바꾸어야만 된다.

-- 직급 높은 순, 같으면 연봉 높은 순서 나열
SELECT *
FROM employee
ORDER BY DECODE(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '사원', 5), salary DESC;
-- DESC로 변경하면 직급 낮은 순으로 출력된다.

-- 부장만 검색
SELECT * FROM employee WHERE jikup = '부장';  -- 오라클에서 비교 연산자는 =

-- 20번 부서의 과장만 검색
SELECT * FROM employee WHERE dep_no = 20 AND jikup = '과장';  -- 오라클 and 연산자

-- 20번 부서 이거나 과장을 검색
SELECT * FROM employee WHERE dep_no = 20 OR jikup = '과장';   -- 오라클 OR 연산자

-- 과장 중에 연봉 3400 이상을 검색
SELECT * FROM employee WHERE jikup = '과장' AND salary >= 3400;

-- 실수령액 4000만원 이상 받는 직원, 세금 12%
SELECT * FROM employee WHERE salary*0.88 >= 4000;

-- 세금 제일 많이 내는 직원 순서, 부서번호 내림차순, 사장이 아닌 직원 검색
SELECT * FROM employee WHERE jikup != '사장' ORDER BY salary*0.12 DESC, dep_no DESC;

-- 20번 부서 중에 연봉 2000 ~ 3000 사이 검색
SELECT * FROM employee WHERE dep_no = 20 AND 2000 <= salary AND salary <= 3000;
SELECT * FROM employee WHERE dep_no = 20 AND salary BETWEEN 2000 AND 3000;
-- 컬럼명 BETWEEN 값1 AND 값2 : 값1 이상 값2 이하 검색 가능, 미만은 검색 불가

-- 직속 상관이 없는 직원 검색
SELECT * FROM employee WHERE mgr_emp_no IS NULL;     -- NULL 값 검색 IS NULL
-- NULL 은 데이터가 아니라서 = 로 검색할 수 없다.
-- = 은 NULL 이 아닌 실존 데이터만 검색할 수 있다.

-- 직속 상관이 있는 직원 검색
SELECT * FROM employee WHERE mgr_emp_no IS NOT NULL;
-- NULL 값 아닌 경우 검색 IS NOT NULL