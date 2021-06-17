-- 36. 최소 연봉, 최대 연봉, 평균 연봉, 연봉총합, 총인원수
SELECT
        MIN(salary)    AS "최소연봉"  -- salary 컬럼에서 최소값 리턴
        ,MAX(salary)   AS "최대연봉"  -- salary 컬럼에서 최대값 리턴
        ,AVG(salary)   AS "평균연봉"  -- salary 컬럼에서 평균값 리턴
                -- 주의!! NULL 있으면 더할때 빠지고, 나누는 개수에서도 빠진다.
        ,SUM(salary)   AS "연봉총합"  -- salary 컬럼에서 총합을 리턴
        ,COUNT(*)      AS "총인원수"  -- COUNT(*)는 총행의 개수
                -- NULL 값이 없는 컬럼을 쓴다.
FROM
        employee;
--

-- 37. 담당직원이 있는 고객의 명수
SELECT COUNT(emp_no) FROM customer;

-- 38. 고객을 담당하는 직원의 명수
SELECT COUNT(DISTINCT emp_no) FROM customer;

-- 39. 직속 상관이 있는 직원의 명수
SELECT COUNT(mgr_emp_no) FROM employee;

-- 39-1 부하직원이 있는 직원의 명수
SELECT COUNT(DISTINCT mgr_emp_no) FROM employee;

-- 40. 직원번호, 직원명, 생일월-생일일 검색
SELECT
        emp_no      "직원번호"
        , emp_name  "직원명"
        , SUBSTR(jumin_num, 3, 2)||'-'||SUBSTR(jumin_num, 5, 2)  "생일월일"
        -- SUBSTR(컬럼명, 시작순서, 개수) : 시작순서부터 개수를 잘라서 반환
FROM
        employee;

SELECT * FROM customer;

-- 41. 모든 컬럼, 모든 행을 검색, 주민번호는 901225-2****** 형태
SELECT
        cus_no
        , cus_name
        , tel_num
        , SUBSTR(jumin_num, 1, 6)||'-'||SUBSTR(jumin_num, 7, 1)||'******' AS "주민번호"
        , emp_no
FROM
        customer;
-- 42. 고객번호, 고객명, 담당직원번호를 출력하면?
-- 단, 담당직원번호가 없으면 NULL 출력하지 말고 '없음' 표시
SELECT
        cus_no
        , cus_name
        , NVL(emp_no||'', '없음')
        -- NVL(컬럼명, NULL을 대체할 데이터) : NULL 값 처리 함수
        -- NULL 값인 경우 원하는 형태로 변경하여 출력
        -- ||'' : 출력하는 데이터를 숫자 -> 문자로 변경
FROM
        customer;

-- 43. 고객번호, 고객명, 담당직원존재여부를 출력하면?
-- 단, 직원번호가 있으면 "있음", 없으면 "없음"으로 표시
SELECT
        cus_no
        , cus_name
        , NVL2(emp_no||'', '있음', '없음')
        -- NVL2(컬럼명, NULL값이 아닌 경우 대체할 데이터, NULL을 대체할 데이터)
        -- NULL 값이 아닌 경우와 NULL 값인 경우 원하는 형태로 변경하여 출력
FROM
        customer;

-- 44. 직원번호, 직원명, 직급, 성별을 출력하면?
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '남'
                WHEN '3' THEN '남'
                WHEN '2' THEN '여'
                WHEN '4' THEN '여'
          END
        -- CASE 컬럼 WHEN 비교 데이터 THEN 리턴값 ... END
        -- 1, 3 -> 남 / 2, 4 -> 여
FROM
        employee;

-- 44-1 ELSE 를 쓴 경우
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '남'
                WHEN '3' THEN '남'
                ELSE '여'
          END
        -- 1, 3 -> 남 / 그 외는 모두 '여' 로 처리
FROM
        employee;

-- 44-2 비교 데이터를 조건문으로 처리
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                WHEN SUBSTR(jumin_num, 7, 1) = '1' THEN '남'
                WHEN SUBSTR(jumin_num, 7, 1) = '3' THEN '남'
                ELSE '여'
          END
FROM
        employee;

-- 44-3 DECODE() 사용
SELECT
        emp_no
        , emp_name
        , jikup
        , DECODE(
                SUBSTR(jumin_num, 7, 1)
                , '1', '남'
                , '3', '남'
                , '여'
        )
        -- DECODE(컬럼명, 비교 데이터, 리턴값, ..., 그 외 값에 대한 리턴값)
FROM
        employee;

-- 45. 직원번호, 직원명, 직급, 출생년도 출력
-- CASE문 사용한 경우
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '19'
                WHEN '2' THEN '19'
                ELSE '20'
          END || SUBSTR(jumin_num, 1, 2)
FROM
        employee;

-- DECODE() 사용한 경우
SELECT
        emp_no
        , emp_name
        , jikup
        , DECODE(
                SUBSTR(jumin_num, 7, 1)
                , '1', '19'
                , '2', '19'
                , '20'
        ) || SUBSTR(jumin_num, 1, 2)
FROM
        employee;

-- 46. 직원번호, 직원명, 직급, 출생년대(4자리)
-- CASE문 사용한 경우
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '19'
                WHEN '2' THEN '19'
                ELSE '20'
          END || SUBSTR(jumin_num, 1, 1) || '0년대'
FROM
        employee;

-- DECODE() 사용한 경우
SELECT
        emp_no
        , emp_name
        , jikup
        , DECODE(
                SUBSTR(jumin_num, 7, 1)
                , '1', '19'
                , '2', '19'
                , '20'
        ) || SUBSTR(jumin_num, 1, 1) || '0년대'
FROM
        employee;

-- 47. 나이순으로 출력
SELECT *
FROM employee
ORDER BY
        CASE
            WHEN SUBSTR(jumin_num, 7, 1) = '1' THEN '19'
            WHEN SUBSTR(jumin_num, 7, 1) = '2' THEN '19'
            ELSE '20'
        END || SUBSTR(jumin_num, 1, 6)
        ASC;
-- 아래 처럼 하면 안된다. 2000년 생이 먼저 나온다. 2000년 생은 주민번호가 00으로 시작한다.
SELECT * FROM employee ORDER BY jumin_num asc;

-- 48. 직급 순서대로 정렬
SELECT *
FROM employee
ORDER BY
        CASE jikup
            WHEN '사장' THEN 1
            WHEN '부장' THEN 2
            WHEN '과장' THEN 3
            WHEN '대리' THEN 4
            WHEN '주임' THEN 5
            ELSE 6
        END
        ASC;

-- DECODE() 사용
SELECT *
FROM employee
ORDER BY
        DECODE(
                jikup
                ,'사장', 1
                ,'부장', 2
                ,'과장', 3
                ,'대리', 4
                ,'주임', 5
                , 6
        ) ASC;


-- 49. 직원번호, 직원명, 입사일(년-월-일(요일) 분기 시분초)
SELECT
        emp_no
        , emp_name
        , TO_CHAR(hire_date,'YYYY-MM-DD(DY) Q AM HH:MI:SS', 'NLS_DATE_LANGUAGE = Korean')
FROM
        employee;

-- AM 추가 : 오전, 오후로 표현
-- HH24 : 0 ~ 23시로 표현
-- 요일 표현 : DAY (영어 풀네임) / DY (영어 약자)
-- 세 번째 옵션에 'NLS_DATE_LANGUAGE = Korean' 추가, DAY (한글 풀네임) / DY (한글 약자)
-- Q : 1 ~ 4 분기 출력

-- 49 - 1 직원번호, 직원명, 입사일(x년-x월-x일(요일) x분기 x시x분x초)
SELECT
        emp_no
        , emp_name
        , TO_CHAR(hire_date, 'YYYY') || '년-'  || TO_CHAR(hire_date, 'MM')  || '월-'
        || TO_CHAR(hire_date, 'DD')  || '일'   || TO_CHAR(hire_date, '(DY)', 'NLS_DATE_LANGUAGE = Korean')
        || TO_CHAR(hire_date, ' Q')  || '분기' || TO_CHAR(hire_date, ' HH') || '시'
        || TO_CHAR(hire_date, 'MI')  || '분'   || TO_CHAR(hire_date, 'SS')  || '초'
FROM
        employee;

-- 2번째 케이스
SELECT
        emp_no
        , emp_name
        , TO_CHAR(hire_date,'YYYY"년"-MM"월"-DD"일"(DY) Q"분기" HH"시"MI"분"SS"초"', 'NLS_DATE_LANGUAGE = Korean')
FROM
        employee;

-- 50. 직원번호, 직원명, 나이 검색
SELECT
        emp_no
        , emp_name
        , TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
          - TO_NUMBER(
                CASE
                    SUBSTR(jumin_num, 7, 1)
                    WHEN '1' THEN '19'
                    WHEN '2' THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 2)
          ) + 1 || '세' AS "나이"
FROM
        employee;

-- 51. 직원번호, 직원명, 근무년차
SELECT
        emp_no "직원번호"
        , emp_name "직원명"
        , CEIL( (SYSDATE - hire_date) / 365)||'년차' "근무년차"
        -- 오라클은  날짜 - 날짜 의 결과값은 날짜 차이만큼의 일수 있다.
        -- CEIL() : 소수 첫째 자리에서 무조건 올림하는 수학 함수의 일종이다.
        -- FLOOR() : 소수 첫째 자리에서 무조건 내림하는 수학 함수의 일종이다.
FROM
        employee;

-- 52. 직원번호, 직원명, 연령대
SELECT
        emp_no
        , emp_name
        , FLOOR(
            (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
                - TO_NUMBER(
                    CASE SUBSTR(jumin_num, 7, 1)
                        WHEN '1' THEN '19'
                        WHEN '2' THEN '19'
                        ELSE '20'
                    END || SUBSTR(jumin_num, 1, 2)
                ) + 1)
            * 0.1) || '0대' "나이"
FROM
        employee;

-- 53. 직원번호, 직원명, 100일잔치날짜(연-월-일)
SELECT
        emp_no
        , emp_name
        , TO_CHAR(
            TO_DATE(
                CASE
                    WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2') THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 6), 'YYYYMMDD'
            ) + 100
          , 'YYYY-MM-DD(DY)', 'NLS_DATE_LANGUAGE = Korean') "100일잔치날짜"
FROM
        employee;
-- 오라클은 날짜에 정수를 더하거나 빼면 결과가 날짜로 나온다

-- 53-1. 개강일이 2021년 5월 12일이고 종강일이 2021년 11월 10일 이다.
-- 며칠 동안 학원 생활을 하나?
SELECT
        TO_DATE('20211110', 'YYYYMMDD')
        - TO_DATE('20210512', 'YYYYMMDD') "일수"
FROM
        dual;

-- 54. 직원번호, 직원명, 현재나이, 입사일 당시 나이
SELECT
        emp_no
        , emp_name
        , TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
            - TO_NUMBER(
                CASE
                    WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2') THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 2))
            + 1 "나이"
        , TO_NUMBER(TO_CHAR(hire_date, 'YYYY'))
            - TO_NUMBER(
                CASE
                    WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2') THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 2))
            + 1 "입사일당시나이"
FROM
        employee;

-- 현재년도 - 출생년도 + 1 -> 현재나이
-- 입사년도 - 출생년도 + 1 -> 입사일 당시 나이

-- 55. 직원번호, 직원명, 주민번호, 다가올생일날(년-월-일), 생일까지 남은일수를 검색
SELECT
        emp_no
        , emp_name
        , jumin_num
        , TO_CHAR(
            TO_DATE(
             CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'MMDD'))
                         - TO_NUMBER(SUBSTR(jumin_num, 3, 4)) < 0
                        THEN '2021'
                  ELSE '2022'
              END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD')
             , 'YYYY-MM-DD')
           "다가올생일날"
        , TO_DATE(
            CASE
                WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'MMDD'))
                      - TO_NUMBER(SUBSTR(jumin_num, 3, 4)) < 0
                    THEN '2021'
                ELSE '2022'
            END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD' )
          - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') || '일'
          "생일까지 남은 일수"
FROM
        employee;

-- 올해생일날짜 - 현재날짜  -> 양수면 생일 안지남(올해), 음수면 생일 지남(내년)
-- 생일까지 남은 일수 계산 방법
-- 만약 올해생일날짜 - 지금날짜 값이 양수면 생일이 안지났으므로 올해생일날짜 - 지금날짜 면 된다.
-- 만약 올해생일날짜 - 지금날짜 값이 음수면 생일이 지났으므로 내년생일날짜 - 지금날짜 면 된다.
SELECT
        emp_no
        , emp_name
        , jumin_num
        , TO_CHAR(TO_DATE(CASE WHEN
                    TO_DATE(
                        TO_CHAR(SYSDATE, 'YYYY') || SUBSTR(jumin_num, 3, 4)
                        , 'YYYYMMDD'
                  ) - SYSDATE >= 0
               THEN TO_CHAR(SYSDATE, 'YYYY')
               ELSE TO_CHAR(SYSDATE + 365, 'YYYY')
           END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD'), 'YYYY-MM-DD') "다가올생일날"
        , TO_DATE(CASE WHEN
                    TO_DATE(
                        TO_CHAR(SYSDATE, 'YYYY') || SUBSTR(jumin_num, 3, 4)
                        , 'YYYYMMDD'
                  ) - SYSDATE >= 0
               THEN TO_CHAR(SYSDATE, 'YYYY')
               ELSE TO_CHAR(SYSDATE + 365, 'YYYY')
           END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD')
           - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') "생일까지 남은 일수"
FROM
        employee
ORDER BY
        5 ASC;   -- SELECT 컬럼 순서 번호로 ORDER BY가 가능하다.
    -- "생일까지 남은 일수" ASC;  -- SELECT 컬럼의 알리아스로 ORDER BY가 가능하다.

-- FLOOR() : -4
SELECT FLOOR(-3.1) FROM DUAL;

-- FLOOR() : -3
SELECT CEIL(-3.1) FROM DUAL;

