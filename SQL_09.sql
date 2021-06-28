-- 140. 연봉 서열대로 직원을 검색하되 1행부터 10행까지만 검색하면?
-- 140-1
SELECT ROWNUM, e.*   -- * 옆에도 별칭을 쓸 수 있다.
FROM employee e

SELECT ROWNUM, dep_no, dep_name, loc
FROM dept

-- 140-2
SELECT ROWNUM, e.*
FROM employee e
WHERE ROWNUM <= 10
ORDER BY salary DESC

-- 140-3
SELECT ROWNUM, e.*
FROM (SELECT * FROM employee ORDER BY salary DESC) e
WHERE ROWNUM <= 10

-- 140-4
SELECT ROWNUM, e.*
FROM (SELECT * FROM employee ORDER BY salary DESC) e
WHERE 11 <= ROWNUM AND ROWNUM <= 20

-- 140-5
-- 답1
SELECT *
FROM (
        SELECT ROWNUM RNUM, e.*
        FROM (SELECT * FROM employee ORDER BY salary DESC) e
        WHERE ROWNUM <= 10
     )
WHERE RNUM >= 1
-- RNUM은 밖에 있는 SELECT문 입장에서는 단순한 컬럼이다.

-- 답2
SELECT *
FROM (
        SELECT ROWNUM RNUM, e.*
        FROM (SELECT * FROM employee ORDER BY salary DESC) e
     )
WHERE RNUM >= 1 AND RNUM <= 10

-- 번외. 연봉 서열 11향부터 20행를 검색하라
SELECT *
FROM (
        SELECT ROWNUM RNUM, e.*
        FROM (SELECT * FROM employee ORDER BY salary DESC) e
        WHERE ROWNUM <= 20
     )
WHERE RNUM >= 11

-- 패턴
SELECT * FROM ( SELECT ROWNUM RNUM, zxcvb.*  FROM (
        원하는 정렬 SELECT 문
) zxcvb WHERE ROWNUM <= 마지막행번호) WHERE RNUM >= 시작행번호

-- 140-6. 고객 나이 서열중 6행부터 10행까지 검색하면?
SELECT * FROM ( SELECT ROWNUM RNUM, zxcvb.*  FROM (
        SELECT * FROM customer
        ORDER BY
            DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')
                  ||SUBSTR(jumin_num, 1, 6)
) zxcvb WHERE ROWNUM <= 10) WHERE RNUM >= 6

-- 140-7. 직원 직급 서열 중 2행부터 5행까지 검색하면?
SELECT * FROM ( SELECT ROWNUM RNUM, zxcvb.*  FROM (
       SELECT * FROM employee
       ORDER BY DECODE(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
) zxcvb WHERE ROWNUM <= 5) WHERE RNUM >= 2

-- 127. 인라인뷰를 사용하면 다음과 같이 문제를 풀 수 있다.
SELECT * FROM
(
SELECT
        dep_no                 DEP_NO
        , jikup                JIKUP
        , SUM(salary)          TOT_SALARY
        , ROUND(AVG(salary),1) AVG_SALARY
        , COUNT(*)       EMP_CNT
FROM
        employee
GROUP BY
        dep_no, jikup
)  WHERE EMP_CNT >= 3
-- 인라인뷰의 alias는 바깥쪽 SELECT문에서는 컬럼으로 취급된다.

-- 135. 월별로 입사월, 인원수를 검색하면? 입사월 오름차순 유지
-- <조건> 입사월 오름차순 유지
-- <조건> 위 결과에서 2월, 9월은 없어서 빠진다. 2월, 9월도 포함시키고 인원수는 0으로 포함하려면?
SELECT m.month||'월'    "입사월"
        , COUNT(e.emp_name) "입사인원수"
FROM (
    SELECT '01' "MONTH" FROM DUAL UNION
    SELECT '02' FROM DUAL UNION SELECT '03' FROM DUAL UNION SELECT '04' FROM DUAL UNION
    SELECT '05' FROM DUAL UNION SELECT '06' FROM DUAL UNION SELECT '07' FROM DUAL UNION
    SELECT '08' FROM DUAL UNION SELECT '09' FROM DUAL UNION SELECT '10' FROM DUAL UNION
    SELECT '11' FROM DUAL UNION SELECT '12' FROM DUAL
) m, employee e
WHERE TO_CHAR(e.hire_date(+), 'MM') = m.month
GROUP BY m.month||'월'
ORDER BY "입사월";

-- 상관쿼리 사용
SELECT m.month||'월'    "입사월"
        , (SELECT COUNT(e.emp_name) FROM employee e WHERE TO_CHAR(e.hire_date, 'MM') = m.month) "입사인원수"
FROM (
    SELECT '01' "MONTH" FROM DUAL UNION
    SELECT '02' FROM DUAL UNION SELECT '03' FROM DUAL UNION SELECT '04' FROM DUAL UNION
    SELECT '05' FROM DUAL UNION SELECT '06' FROM DUAL UNION SELECT '07' FROM DUAL UNION
    SELECT '08' FROM DUAL UNION SELECT '09' FROM DUAL UNION SELECT '10' FROM DUAL UNION
    SELECT '11' FROM DUAL UNION SELECT '12' FROM DUAL
) m
ORDER BY "입사월";

-- 141. 오늘부터 10일 이후까지 날짜 중에 토요일, 일요일, 월요일을 제외한 날의 개수를 구하면?
SELECT COUNT(*) FROM (
    SELECT SYSDATE "XDAY" FROM DUAL UNION
    SELECT SYSDATE + 1 FROM DUAL UNION SELECT SYSDATE + 2 FROM DUAL UNION SELECT SYSDATE + 3 FROM DUAL UNION
    SELECT SYSDATE + 4 FROM DUAL UNION SELECT SYSDATE + 5 FROM DUAL UNION SELECT SYSDATE + 6 FROM DUAL UNION
    SELECT SYSDATE + 7 FROM DUAL UNION SELECT SYSDATE + 8 FROM DUAL UNION SELECT SYSDATE + 9 FROM DUAL UNION
    SELECT SYSDATE + 10 FROM DUAL
)
WHERE TO_CHAR(xday, 'DY', 'NLS_DATE_LANGUAGE = KOREAN') NOT IN('토', '일', '월')

-- 142. 이번달 중에 토요일, 일요일을 제외한 날의 개수를 구하면? = 이번달 평일 수 구하기
SELECT COUNT(*) FROM (

)
WHERE TO_CHAR( , 'DY', 'NLS_DATE_LANGUAGE = KOREAN') NOT IN('토', '일')