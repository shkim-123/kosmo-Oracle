-- 124. 부서별로 부서번호, 급여합, 평균급여, 인원수를 출력하면?
-- 단, 평균은 소수 둘째 자리에서 반올림 할 것
SELECT
        dep_no                  부서번호
        , SUM(salary)           급여합
        , ROUND(AVG(salary), 1) 평균급여
        , COUNT(*)||'명'        인원수
FROM
        employee
GROUP BY
        dep_no;

-- 125. 직급별로 직급, 급여합, 평균급여, 인원수를 출력하면?
-- 단, 평균은 소수 둘째 자리에서 반올림 할 것
SELECT
        jikup                   직급
        , SUM(salary)           급여합
        , ROUND(AVG(salary), 1) 평균급여
        , COUNT(*)||'명'        인원수
FROM
        employee
GROUP BY
        jikup;

-- 126. 부서별, 직급별, 부서번호, 직급, 급여합, 평균급여, 인원수를 출력하면?
-- 단, 평균은 소수 둘째 자리에서 반올림 할 것
SELECT
        dep_no                 부서번호
        , jikup                직급
        , SUM(salary)          급여합
        , ROUND(AVG(salary),1) 평균급여
        , COUNT(*)||'명'       인원수
FROM
        employee
GROUP BY
        dep_no, jikup
ORDER BY
        1;

-- 127. 부서별, 직급별, 부서번호, 직급, 급여합, 평균급여, 인원수를 출력하되
-- 인원수는 3명 이상인 출력하면?
SELECT
        dep_no                 부서번호
        , jikup                직급
        , SUM(salary)          급여합
        , ROUND(AVG(salary),1) 평균급여
        , COUNT(*)||'명'       인원수
FROM
        employee
GROUP BY
        dep_no, jikup
HAVING
        COUNT(*) >= 3;

-- 128. 부서별, 성별로 부서번호, 성별, 급여합, 평균급여, 인원수를 출력하면?
SELECT
        dep_no                  부서번호
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '남', '3', '남', '여')  성별
        , SUM(salary)           급여합
        , ROUND(AVG(salary), 1) 평균급여
        , COUNT(*)||'명'        인원수
FROM
        employee
GROUP BY
        dep_no, DECODE(SUBSTR(jumin_num, 7, 1), '1', '남', '3', '남', '여')
ORDER BY
        1;

-- CASE 문
SELECT
        dep_no                  부서번호
        , CASE
             WHEN SUBSTR(jumin_num, 7, 1) IN ('1', '3') THEN '남'
             ELSE '여'
          END 성별
        , SUM(salary)           급여합
        , ROUND(AVG(salary), 1) 평균급여
        , COUNT(*)||'명'        인원수
FROM
        employee
GROUP BY
        dep_no
        , CASE
             WHEN SUBSTR(jumin_num, 7, 1) IN ('1', '3') THEN '남'
             ELSE '여'
          END
ORDER BY
        1;

-- 129. 입사년도별로 입사년도, 인원수를 출력하고 년도별로 오름차순 하면?
SELECT
        TO_CHAR(hire_date, 'YYYY')  입사년도
        , COUNT(*)||'명'            인원수
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'YYYY')
ORDER BY
        1;

-- 130. 부서별로 부서번호, 평균근무년수를 출력하면?
-- (근년수는 소수점 둘째 자리에서 반올림할 것)
SELECT
        dep_no      부서번호
        , ROUND(
                AVG((SYSDATE - hire_date)/365), 1
        ) 평균근무년수
FROM
        employee
GROUP BY
        dep_no;

-- 131. 입사분기별로 입사분기, 인원수를 출력하면?
SELECT
        TO_CHAR(hire_date, 'Q')||'분기' 입사분기
        , COUNT(*)                      인원수
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'Q');

-- 132. 입사연대별, 성별로 입사연대, 성별, 연대별입사자수 출력하면?
SELECT
        FLOOR(TO_NUMBER(TO_CHAR(hire_date, 'YYYY'))*0.1)||'0년대'      입사연대
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '남', '3', '남', '여')  성별
        , COUNT(*)       연대별입사자수
FROM
        employee
GROUP BY
        FLOOR(TO_NUMBER(TO_CHAR(hire_date, 'YYYY'))*0.1)||'0년대'
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '남', '3', '남', '여');

-- 133. 직원명, 입사일(년-월-일 ~/4분기 한글 1자리 요일), 퇴직일(년-월-일) 출력하면?
-- <조건> 퇴직일은 입사 후 20년 5개월 10일 후
SELECT
        emp_name        직원명
        , TO_CHAR(hire_date, 'YYYY-MM-DD Q/"4분기" DY', 'NLS_DATE_LANGUAGE = Korean')  입사일
        , TO_CHAR(ADD_MONTHS(hire_date+10, 5) + 20*365, 'YYYY-MM-DD')   퇴직일
FROM
        employee;

-- 134. 직원들이 있는 부서별로 부서번호, 부서위치, 직원수를 출력하면? 모든 부서 다 나와라
-- ORACLE JOIN
SELECT
        d.dep_no    부서번호
        , d.loc     부서위치
        , COUNT(e.emp_no) 직원수
FROM
        dept d, employee e
WHERE
        e.dep_no = d.dep_no(+)
GROUP BY
        d.dep_no, d.loc
ORDER BY
        1;

-- ANSI JOIN
SELECT
        d.dep_no    부서번호
        , d.loc     부서위치
        , COUNT(e.emp_no) 직원수
FROM
        dept d RIGHT OUTER JOIN employee e ON e.dep_no = d.dep_no
GROUP BY
        d.dep_no, d.loc
ORDER BY
        1;

-- 서브쿼리
SELECT
        d.dep_no    부서번호
        , d.loc     부서위치
        , (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no )직원수
FROM
        dept d
ORDER BY
        1;

-- 135. 월별로 입사월, 인원수를 검색하면? 입사월 오름차순 유지
-- <조건> 위 결과에서 2월, 9월은 없어서 빠진다.
-- 2월, 9월도 포함시키고 인원수는 0으로 포함하려면?
SELECT
        TO_CHAR(hire_date, 'MM') 입사월
        ,COUNT(*)                인원수
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'MM')
UNION ALL
SELECT
        '02'
        , 0
FROM
        DUAL
UNION ALL
SELECT
        '09'
        , 0
FROM
        DUAL
ORDER BY
        1;

-- 136. employee 테이블에서 직급순서대로 정렬하여 직급별로 직급, 직급평균연봉, 인원수를 검색하면?
-- (높은 직급이 먼저 나와야함)
SELECT
        jikup           직급
        , ROUND(AVG(salary),1)   직급평균연봉
        , COUNT(*)      인원수
FROM
        employee
GROUP BY
        jikup
HAVING
        COUNT(*) >= 5
-- 인원수가 5 이상인 컬럼만 보고 싶을 경우
ORDER BY
    --  DECODE(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5);
        DECODE("직급", '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5);
-- ORDER BY 에는 리얼컬럼, 순서번호, 알리아스가 올 수 있다.

-- 137. 부서별 부서번호, 부서명, 직원수, 직원이관리하는고객수를 검색하면?
SELECT
        dep_no         부서번호
        , dep_name     부서명
        , (SELECT COUNT(*) FROM employee e WHERE d.dep_no = e.dep_no) 직원수
        , (SELECT COUNT(*) FROM employee e, customer c WHERE d.dep_no = e.dep_no
                AND e.emp_no = c.emp_no) 관리고객수
FROM
        dept d ;

-- ORACLE JOIN
SELECT
        d.dep_no           부서번호
       , d.dep_name        부서명
       , COUNT(DISTINCT e.emp_no) 직원수
    -- , COUNT(e.emp_no)
    -- DISTINCT를 안 쓰면 직원수가 중복되서 나온다.
       , COUNT(c.cus_no)          관리고객수
    -- , COUNT(DISTINCT c.cus_no)
    -- DISTINCT를 쓰면 고객을 담당하는 직원수가 된다.
FROM employee e, dept d, customer c
WHERE e.dep_no(+) = d.dep_no AND e.emp_no = c.emp_no(+)
GROUP BY d.dep_no
       , d.dep_name
ORDER BY 1;

-- ANSI JOIN
SELECT
        d.dep_no           부서번호
       , d.dep_name        부서명
       , COUNT(DISTINCT e.emp_no) 직원수
       , COUNT(c.cus_no)          관리고객수
FROM employee e RIGHT OUTER JOIN dept d  ON  e.dep_no = d.dep_no
                LEFT OUTER JOIN customer c ON e.emp_no = c.emp_no
GROUP BY d.dep_no
       , d.dep_name
ORDER BY 1;


-- 138. 퇴직일이 60세라는 기준 하에 아래처럼 출력하면?
-- 직원번호, 직원명, 근무년차, 퇴직일까지 남은 년도, 생일(년-월-일 요일명),
-- 소속부서명, 직속상관명, 직속상관 부서명.
-- 단, 모든 직원 다 나오고, 직급 높은 사람이 먼저 나오고 직급이 같으면 나이가 많은 사람이 나와야함.
-- SUBQUERY
SELECT
        emp_no         직원번호
        , emp_name     직원명
        , CEIL((SYSDATE - hire_date)/365)  근무년차
        , 60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(
                DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                ||SUBSTR(jumin_num, 1, 2)) + 1 ) 퇴직일까지남은년도
        , TO_CHAR(TO_DATE(DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')
                        ||SUBSTR(jumin_num, 1, 6), 'YYYYMMDD'), 'YYYY-MM-DD DY'
						, 'NLS_DATE_LANGUAGE = KOREAN') 생일
        , (SELECT dep_name FROM dept d WHERE d.dep_no = e.dep_no)    소속부서명
        , (SELECT e2.emp_name FROM employee e2 WHERE e2.emp_no = e.mgr_emp_no)  직속상관명
        , (SELECT d.dep_name FROM employee e2, dept d
                        WHERE e2.emp_no = e.mgr_emp_no AND d.dep_no = e2.dep_no) 직속상관부서명
FROM
        employee e
ORDER BY
        DECODE(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)

-- ORACLE JOIN
SELECT
        e1.emp_no       직원번호
        , e1.emp_name   직원명
        , CEIL((SYSDATE - e1.hire_date)/365)  근무년차
        , 60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(
                DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                ||SUBSTR(e1.jumin_num, 1, 2)) + 1 ) 퇴직일까지남은년도
        , TO_CHAR(TO_DATE(DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                        ||SUBSTR(e1.jumin_num, 1, 6), 'YYYYMMDD'), 'YYYY-MM-DD DY'
						, 'NLS_DATE_LANGUAGE = KOREAN') 생일
        , d1.dep_name   소속부서명
        , e2.emp_name   직속상관명
        , d2.dep_name   직속상관부서명
FROM employee e1, dept d1, employee e2, dept d2
WHERE e1.dep_no = d1.dep_no(+) AND e1.mgr_emp_no = e2.emp_no(+) AND e2.dep_no = d2.dep_no(+)
ORDER BY DECODE(e1.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
        , DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 6)

-- ANSI JOIN
SELECT
        e1.emp_no       직원번호
        , e1.emp_name   직원명
        , CEIL((SYSDATE - e1.hire_date)/365)  근무년차
        , 60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(
                DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                ||SUBSTR(e1.jumin_num, 1, 2)) + 1 ) 퇴직일까지남은년도
        , TO_CHAR(TO_DATE(DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                        ||SUBSTR(e1.jumin_num, 1, 6), 'YYYYMMDD'), 'YYYY-MM-DD DY'
						, 'NLS_DATE_LANGUAGE = KOREAN') 생일
        , d1.dep_name   소속부서명
        , e2.emp_name   직속상관명
        , d2.dep_name   직속상관부서명
FROM employee e1 LEFT OUTER JOIN dept d1 ON e1.dep_no = d1.dep_no
                 LEFT OUTER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
                 LEFT OUTER JOIN dept d2 ON e2.dep_no = d2.dep_no
ORDER BY DECODE(e1.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
        , DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 6)