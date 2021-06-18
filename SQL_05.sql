-- 56. 직원번호, 직원명, 직급, 연봉(xxx,xxx,xxx만원)을 검색하면?
SELECT emp_no
        ,emp_name
        , jikup
        ,TO_CHAR(salary, '999,999,999')||'만원' "연봉"
  FROM employee;
-- 999,999,999 -> 자리에 숫자가 없으면 숫자 표시 안함
-- 0 -> 자리에 숫자가 없으면 숫자 표시 (자릿수가 맞춰진다)

-- 57. employee 테이블에서 수요일에 태어난 직원을 검색하라
SELECT *
  FROM employee
 WHERE TO_CHAR(TO_DATE
       (
           CASE
               WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2')
               THEN '19'
               ELSE '20'
           END || SUBSTR(jumin_num, 1, 6), 'YYYYMMDD'
       )
         , 'DY', 'NLS_DATE_LANGUAGE = Korean') = '수';
    --   , 'D') = '4';    -- D -> 요일이 숫자로 출력된다. 수요일 : 4
    --   , 'DY' ) = 'WED';

-- 58. employee 테이블에서 70년대생 남자 직원을 검색하라
SELECT *
  FROM employee
 WHERE SUBSTR(jumin_num, 1, 1) = '7'
       AND SUBSTR(jumin_num, 7, 1) = '1' ;

 -- 59. 1960년대, 1970년대 출생자 중 남자만 검색하라
SELECT *
  FROM employee
 WHERE SUBSTR(jumin_num, 1, 1) IN('6', '7')
       AND SUBSTR(jumin_num, 7, 1) = '1' ;

-- 60. 오래 근무한 직원이 먼저 나오게 검색하면?
SELECT *
FROM employee
ORDER BY hire_date;

SELECT *
FROM employee
ORDER BY SYSDATE - hire_date DESC;

-- 61. 직원번호, 직원명, 근무일수, 근무개월수
-- , 입사후 5개월 후 날짜(년-월-일), 입사한 달의 마지막 날짜(년-월-일)
-- , 입사한 날짜 기준 돌아오는 일요일날짜(년-월-일)를 검색하면?
-- 단, 근무일수는 소수 2자리에서 반올림
SELECT
        emp_no         직원번호
        , emp_name     직원명
        , ROUND(SYSDATE - hire_date, 1)   근무일수
        , TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),1)  근무개월수
        , TO_CHAR(ADD_MONTHS(hire_date, 5),'YYYY-MM-DD')    입사후5개월후날짜
        , TO_CHAR(LAST_DAY(hire_date), 'YYYY-MM-DD')   입사한달의마지막날짜
        , TO_CHAR(NEXT_DAY(hire_date, 1), 'YYYY-MM-DD') 입사돌아오는일요일
FROM
        employee;

-- MONTHS_BETWEEN(날짜1, 날짜2) -> 날짜1 - 날짜2 를 개월수로 리턴하기
-- ADD_MONTHS(날짜, 개월 수) -> 날짜에 개월 수를 더한 날짜를 리턴하기
-- LAST_DAY(날짜) -> 날짜가 속한 달의 마지막 날짜를 리턴하기
-- NEXT_DAY(날짜, 요일정수) -> 날짜 기준으로 돌아오는 요일의 날짜를 리턴하기
                    --  -> 요일 정수는 1 ~ 7(일 ~ 토)
-- 날짜1 - 날짜2 -> 날짜1과 날짜2의 차이를 일수로 리턴하기
-- 날짜 + 정수   -> 날짜에다 정수만큼의 일수를 더한 만큼의 날의 날짜를 리턴하기
-- 날짜 - 정수   -> 날짜에다 정수만큼의 일수를 뺀 만큼의 날의 날짜를 리턴하기

-- 62. 직급이 과장인 직원을 검색하면?
SELECT * FROM employee WHERE jikup = '과장';

-- 63. 직급이 과장이 아닌 직원을 검색하면?
SELECT * FROM employee WHERE jikup != '과장';
SELECT * FROM employee WHERE jikup <> '과장';

-- 64. 부서번호가 10번이고 직급이 과장인 직원을 검색하면?
SELECT * FROM employee WHERE dep_no = 10 AND jikup = '과장';

-- 65. 직급이 과장 또는 부장인 직원을 검색하면?
SELECT * FROM employee WHERE jikup = '과장' OR jikup = '부장';
SELECT * FROM employee WHERE jikup IN('과장', '부장');
SELECT * FROM employee WHERE jikup = ANY('과장', '부장');

-- 66. 10번, 20번 부서 중에 직급이 과장인 직원을 검색하면?
SELECT * FROM employee WHERE (dep_no = 10 OR dep_no = 20) AND jikup = '과장';
SELECT * FROM employee WHERE dep_no IN(10, 20) AND jikup = '과장';
-- IN() 함수는 AND가 있어도 IN()에 있는 데이터가 먼저 계산된다.

-- 67. customer 테이블에서 담당직원이 없는 고객을 검색하면?
SELECT * FROM customer WHERE emp_no IS NULL;

-- 68. customer 테이블에서 담당직원이 있는 고객을 검색하면?
SELECT * FROM customer WHERE emp_no IS NOT NULL;

-- 69. customer 테이블에서 담당직원 번호가 9번이 아닌 고객을 검색하면?
SELECT * FROM customer WHERE emp_no != 9 OR emp_no IS NULL;
SELECT * FROM customer WHERE NVL(emp_no, 0) != 9;
-- emp_no IS NULL 조건도 붙이는 이유는 emp_no가 NULL 일 경우
-- emp_no != 9 조건에 포함되지 않기 때문이다.
-- 즉 NULL 은 IS NULL 또는 IN NOT NULL 연산자에 의해서만 검색된다.

-- 70. employee 테이블에서 연봉이 3000 만원 ~ 4000만원 사이의 직원을 검색하면?
SELECT * FROM employee WHERE salary >= 3000 AND salary <= 4000;
SELECT * FROM employee WHERE salary BETWEEN 3000 AND 4000;

-- 71. employee 테이블에서 연봉이 3000만원 이상 ~ 4000만원 미만 사이의 직원을 검색하면?
SELECT * FROM employee WHERE 3000 <= salary AND salary > 4000;
SELECT * FROM employee WHERE (salary BETWEEN 3000 AND 4000) AND salary != 4000;

-- 72. employee 테이블에서 연봉을 5% 인상됐다고 가정하고 3000이상인 직원을 검색하면?
SELECT * FROM employee WHERE salary*1.05 >= 3000;

-- 73. employee 테이블에서 입사일 이 '1995-1-1' 이상인 직원을 검색하면?
SELECT * FROM employee WHERE hire_date >= TO_DATE('1995-1-1', 'YYYY-MM-DD');

-- 74. employee 테이블에서 입사일이 1990년 ~ 1999년 사이인 직원을 검색하면?
SELECT * FROM employee
WHERE hire_date BETWEEN TO_DATE('19900101', 'YYYYMMDD')
                AND TO_DATE('19991231', 'YYYYMMDD');

SELECT * FROM employee
WHERE TO_DATE('19900101', 'YYYYMMDD') <= hire_date
        AND hire_date < TO_DATE('20000101', 'YYYYMMDD');

-- 75. employee 테이블에서 부서번호가 10번 또는 30번인 직원 중에
-- 연봉이 3000 미만이고 입사일이 '1996-01-01' 미만 직원을 검색하면?
SELECT * FROM employee
WHERE dep_no IN(10, 30)
        AND salary < 3000
        AND hire_date < TO_DATE('1996-01-01', 'YYYY-MM-DD');

-- 76. employ 테이블에서 성이 김씨인 직원을 검색하면?
SELECT * FROM employee WHERE SUBSTR(emp_name, 1, 1) = '김';
SELECT * FROM employee WHERE emp_name LIKE '김%';
-- WHERE 컬럼명 LIKE '패턴문자열'
-- -> 컬럼명 안의 데이터가 패턴문자열을 갖고 있으면 그 행을 검색하라
-- emp_name LIKE '김%'
-- -> 김이 첫글자고 두번째는 무엇이 와도 좋고 길이에 제한없는 문자패턴을 골라라
-- -> 문자패턴 안의 % 는 무엇이 와도 좋고 길이에 제한없음의 의미이다.

-- 77. employ 테이블에서 성이 황씨인 직원을 검색하면?
SELECT * FROM employee
WHERE SUBSTR(emp_name, 1, 1) = '황' AND SUBSTR(emp_name, 1, 2) <> '황보';

SELECT * FROM employee
WHERE emp_name LIKE '황%' AND emp_name NOT LIKE '황보%';

-- 78. employee 테이블에서 이름이 2자인 직원을 검색하면?
SELECT * FROM employee WHERE LENGTH(emp_name) = 2;
-- LENGTH(컬럼명) -> 컬럼명 안의 문자데이터의 길이를 0이상의 정수로 리턴해주는 함수

-- 79. employee 테이블에서 이름이 김으로 끝나는 직원을 검색하면?
SELECT * FROM employee WHERE emp_name LIKE '%김';
SELECT * FROM employee WHERE SUBSTR(emp_name, LENGTH(emp_name), 1) = '김';

-- 80. employee 테이블에서 성이 김씨이고 3글자인 직원을 검색하면?
SELECT * FROM employee WHERE emp_name LIKE '김%' AND LENGTH(emp_name) = 3;
SELECT * FROM employee WHERE emp_name LIKE '김__';

-- 81. employee 테이블에서 이름에 김이란 문자를 가진 직원을 검색하면?
SELECT * FROM employee WHERE emp_name LIKE '%김%';

-- 82. employee 테이블에서 성이 김씨가 아닌 직원을 검색하면?
SELECT * FROM employee WHERE emp_name NOT LIKE '김%';

-- 83. employee 테이블에서 이름 중간에만 김이 들어간 직원을 검색하면?
SELECT * FROM employee
WHERE emp_name LIKE '%김%'
        AND emp_name NOT LIKE '김%' AND emp_name NOT LIKE '%김';

-- 84. employee 테이블에서 여자 직원을 검색하라
SELECT * FROM employee
WHERE SUBSTR(jumin_num, 7, 1) IN ('2', '4');

SELECT * FROM employee
WHERE jumin_num LIKE '______2%' OR jumin_num LIKE '______4%';

-- 만약 주민번호 중간에 - 가 있다면 아래 처럼 해도 된다.
SELECT * FROM employee
WHERE jumin_num LIKE '%-2%' OR jumin_num LIKE '%-4%';

-- 85. employee 테이블에서 1960년대, 1970년대 출생자중 남자만 검색하라
SELECT * FROM employee
WHERE SUBSTR(jumin_num, 1, 1) IN('6', '7') AND SUBSTR(jumin_num, 7, 1) = '1';

SELECT * FROM employee
WHERE jumin_num LIKE '6_____1%' OR jumin_num LIKE '7_____1%';

-- 86. 직원번호, 직원명, 소속부서명 검색?
SELECT
        e.emp_no
        , e.emp_name
        , d.dep_name
FROM
        employee e, dept d
WHERE
        e.dep_no = d.dep_no

-- 87. 고객번호, 고객명, 고객담당직원이름 검색?
SELECT
        c.cus_no 고객번호
        , c.cus_name 고객명
        , e.emp_name 고객담당직원이름
FROM
        customer c, employee e
WHERE
        c.emp_no = e.emp_no