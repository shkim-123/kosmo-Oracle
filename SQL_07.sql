-- 108. 최고 연봉을 받는 직원을 검색하라
SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

-- 109. 평균 연봉 이상을 받는 직원을 검색하라
SELECT *
FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee);

-- 110. 20번 부서에서 최고 연봉자 직원을 검색하라
SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee WHERE dep_no = 20) AND dep_no = 20;

-- 111. 직원명, 직급, 연봉, 전체연봉에서 차지하는 비율을 검색하라.
-- 전체연봉에서 차지하는 비율은 소수점 버림하고 %로 표현하라.
-- 단, 높은 비율이 먼저 나오게 정렬하라.
SELECT emp_name   직원명
        , jikup   직급
        , salary  연봉
        , FLOOR(salary/(SELECT SUM(salary) FROM employee)*100)||'%'  비율
FROM employee
ORDER BY salary/(SELECT SUM(salary) FROM employee)*100 DESC;

-- 112. 10번 부서 직원들이 관리하는 고객번호, 고객명, 직원번호를 검색하면?
-- 비상관 쿼리
SELECT cus_no, cus_name, emp_no
FROM customer
WHERE emp_no = ANY(SELECT emp_no FROM employee WHERE dep_no = 10);
-- WHERE emp_no IN(SELECT emp_no FROM employee WHERE dep_no = 10);

-- JOIN한 경우
SELECT c.cus_no, c.cus_name, c.emp_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.dep_no = 10;

-- 상관쿼리
SELECT cus_no, cus_name, emp_no
FROM customer c
WHERE (SELECT dep_no FROM employee e WHERE c.emp_no = e.emp_no) = 10;
-- WHERE (SELECT COUNT(*) FROM employee e WHERE c.emp_no = e.emp_no AND e.dep_no = 10) > 0;

-- 113. 평균 연봉 이상이고 최대 연봉 미만의
-- 직원명, 연봉, 전체평균연봉, 전체최대연봉을 출력하면?
SELECT emp_name   직원명
        , salary  연봉
        , (SELECT AVG(salary) FROM employee)  전체평균연봉
        , (SELECT MAX(salary) FROM employee)  전체최대연봉
FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee)
        AND salary < (SELECT MAX(salary) FROM employee);

-- 114. 최고 연봉 직원의 직원번호, 직원명, 부서명, 연봉을 검색하면?
SELECT emp_no, emp_name, dep_name, salary
FROM employee e, dept d
WHERE salary = (SELECT MAX(salary) FROM employee)
        AND e.dep_no = d.dep_no;

-- 115. 담당 고객이 2명 이상인 직원번호, 직원명, 직급을 검색하면?
SELECT e.emp_no, e.emp_name, e.jikup
FROM  employee e
WHERE (SELECT COUNT(*) FROM customer c WHERE e.emp_no = c.emp_no) >= 2;

-- 116. 직원번호, 직원명, 소속부서명을 검색하면?
-- 조인
SELECT e.emp_no 직원번호
        , e.emp_name 직원명
        , d.dep_name 부서명
FROM employee e, dept d
WHERE e.dep_no = d.dep_no;

-- 서브쿼리 / 상관 쿼리
SELECT emp_no       직원번호
        , emp_name  직원명
        , (SELECT dep_name FROM dept d WHERE e.dep_no = d.dep_no)  소속부서명
FROM employee e;

-- 117. 직원번호, 직원명, 연봉, 연봉 순위를 출력하면? 단, 연봉 순위를 오름차순 유지
SELECT emp_no           직원번호
        , emp_name      직원명
        , salary        연봉
        , (SELECT COUNT(*) + 1 FROM employee e2 WHERE e1.salary < e2.salary) 연봉순위
FROM employee e1
ORDER BY 4;

-- 118. 직원번호, 직원명, 담당고객수를 출력하면?
SELECT emp_no       직원번호
        , emp_name  직원명
        , (SELECT COUNT(*) FROM customer c WHERE c.emp_no = e.emp_no) 담당고객수
FROM employee e

-- 119. 부서명, 부서직원수, 부서담당고객수를 출력하면?
SELECT d.dep_name       부서명
        , (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no) 부서직원수
        , (SELECT COUNT(*) FROM employee e, customer c
            WHERE d.dep_no = e.dep_no AND e.emp_no = c.emp_no) 부서담당고객수
FROM dept d;

-- 테이블 변경
UPDATE employee SET dep_no = 40 WHERE emp_no = 2;
COMMIT;

-- 120. 직원번호, 직원명, 직급, 주민번호, 직급서열순위를 출력하면?
-- 단, 직급이 같으면 나이 많은 직원이 직급서열순위 이다.
-- 그리고 직급서열순위를 오름차순 유지
SELECT emp_no          직원번호
        , emp_name     직원명
        , jikup        직급
        , jumin_num    주민번호
        , (SELECT COUNT(*) + 1 FROM employee e2
            WHERE
                CASE  -- 직급 같지 않은 경우
                    WHEN e1.jikup <> e2.jikup
                    THEN DECODE(e1.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
                END > DECODE(e2.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
                OR
                CASE    -- 직급 같은 경우
                    WHEN e1.jikup = e2.jikup
                    THEN DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                || SUBSTR(e1.jumin_num, 1, 6)
                END  >  DECODE(SUBSTR(e2.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                || SUBSTR(e2.jumin_num, 1, 6)
            ) 직급서열순위
FROM employee e1
ORDER BY 5;

-- 직급까지만 정렬
SELECT emp_no          직원번호
        , emp_name     직원명
        , jikup        직급
        , jumin_num    주민번호
        , (SELECT COUNT(*)+1 FROM employee e2
                    WHERE DECODE(e1.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
                        > DECODE(e2.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
            )

           직급서열순위
FROM employee e1
ORDER BY 5;