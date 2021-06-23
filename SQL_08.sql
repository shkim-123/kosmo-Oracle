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
        , COUNT(*)              인원수
FROM
        employee
GROUP BY
        dep_no, DECODE(SUBSTR(jumin_num, 7, 1), '1', '남', '3', '남', '여')
ORDER BY
        1;

-- 129. 입사년도별로 입사년도, 인원수를 출력하고 년도별로 오름차순 하면?
SELECT
        TO_CHAR(hire_date, 'YYYY')  입사년도
        , COUNT(*)                  인원수
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'YYYY')
ORDER BY
        1;