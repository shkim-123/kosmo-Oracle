-- 90. 직원번호, 직원명, 소속부서명 검색?
-- ORACLE INNER JOIN
-- 테이블에 별칭을 주지 않고 조인한 것
SELECT employee.emp_no, employee.emp_name, dept.dep_name
FROM employee, dept
WHERE employee.dep_no = dept.dep_no;

-- 테이블에 별칭을 주고 조인한 것 (사용多)
SELECT e.emp_no, e.emp_name, d.dep_name
FROM employee e, dept d
WHERE e.dep_no = d.dep_no;

-- ANSI INNER JOIN
SELECT e.emp_no, e.emp_name, d.dep_name
FROM employee e INNER JOIN dept d
ON e.dep_no = d.dep_no;

-- 91. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?
-- <조건> 담당직원이 있는 고객만 출력
-- ORACLE JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no;

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e
ON c.emp_no = e.emp_no;

-- 92. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?
-- <조건> 10번 부서의 담당직원이 있는 고객만 출력
-- ORACLE JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND dep_no = 10;

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e
ON c.emp_no = e.emp_no
WHERE dep_no = 10;

-- 93. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?
-- <조건> 연봉이 3000만원 이상인 담당직원이 있는 고객만 포함
-- ORACLE JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND salary >= 3000;

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e
ON c.emp_no = e.emp_no
WHERE salary >= 3000;

-- 94. 직원명, 직원직급, 직원부서명, 담당고객명, 고객전화를 출력하면?
-- <조건> 직원 이름 오름차순 정렬
-- ORACLE JOIN
SELECT e.emp_name, e.jikup, d.dep_name, c.cus_name, c.tel_num
FROM employee e, dept d, customer c
WHERE d.dep_no = e.dep_no AND e.emp_no = c.emp_no
ORDER BY e.emp_name;

-- ANSI JOIN
SELECT e.emp_name, e.jikup, d.dep_name, c.cus_name, c.tel_num
FROM (employee e INNER JOIN dept d ON d.dep_no = e.dep_no)
                INNER JOIN customer c ON e.emp_no = c.emp_no
ORDER BY e.emp_name;

-- 95. 직원명, 직원직급, 소속부서명, 연동등급을 출력하면?
-- 연봉등급 오름차순, 직급높은순서 오름차순, 나이높은순서 내림 유지 요망
-- ORACLE JOIN
SELECT e.emp_name, e.jikup, d.dep_name, s.sal_grade_no
FROM employee e, dept d, salary_grade s
WHERE e.dep_no = d.dep_no AND e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY s.sal_grade_no, DECODE(e.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
        , DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '1', '19', '20')
                ||SUBSTR(e.jumin_num, 1, 6);

-- ANSI JOIN
SELECT e.emp_name, e.jikup, d.dep_name, s.sal_grade_no
FROM employee e INNER JOIN dept d ON e.dep_no = d.dep_no
        INNER JOIN salary_grade s ON e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY s.sal_grade_no, DECODE(e.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
        , DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '1', '19', '20')
                ||SUBSTR(e.jumin_num, 1, 6);

-- 96. 부하직원명, 부하직원직급, 직속상관명, 직속상관직급을 출력하면?
-- <조건> 상관이 있는 직원만 포함
-- ORACLE JOIN
SELECT e1.emp_name 부하직원명, e1.jikup 부하직원직급
     , e2.emp_name 직속상관명, e2.jikup 직속상관직급
FROM employee e1, employee e2
WHERE e1.mgr_emp_no = e2.emp_no;

-- ANSI JOIN
SELECT e1.emp_name 부하직원명, e1.jikup 부하직원직급
      , e2.emp_name 직속상관명, e2.jikup 직속상관직급
FROM employee e1 INNER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no;

-- 97. 직속상관명, 직속상관직급, 부하직원명, 부하직원직급을 출력하면?
-- <조건> 상관이 있는 직원만 포함
-- ORACLE JOIN
SELECT e1.emp_name 직속상관명, e1.jikup 직속상관직급
        , e2.emp_name 부하직원명, e2.jikup 부하직원직급
FROM employee e1, employee e2
WHERE e1.emp_no = e2.mgr_emp_no;

-- ANSI JOIN
SELECT e1.emp_name 직속상관명, e1.jikup 직속상관직급
        , e2.emp_name 부하직원명, e2.jikup 부하직원직급
FROM employee e1 INNER JOIN employee e2 ON e1.emp_no = e2.mgr_emp_no;

-- 98. 직원명, 직원직급, 소속부서명, 연봉등급, 직속상관명, 직속상관직급, 담당고객명을 출력하면?
-- ORACLE JOIN
SELECT e1.emp_name       직원명
        , e1.jikup       직원직급
        , d.dep_name     소속부서명
        , s.sal_grade_no   연봉등급
        , e2.emp_name      직속상관명
        , e2.jikup         직속상관직급
        , c.cus_name     담당고객명
FROM employee e1, dept d, employee e2, customer c, salary_grade s
WHERE e1.dep_no = d.dep_no
        AND e2.emp_no = e1.mgr_emp_no
        AND e1.salary BETWEEN s.min_salary AND s.max_salary
        AND e1.emp_no = c.emp_no ;

-- ANSI JOIN
SELECT e1.emp_name       직원명
        , e1.jikup       직원직급
        , d.dep_name     소속부서명
        , s.sal_grade_no   연봉등급
        , e2.emp_name      직속상관명
        , e2.jikup         직속상관직급
        , c.cus_name     담당고객명
FROM employee e1 INNER JOIN dept d ON e1.dep_no = d.dep_no
                 INNER JOIN employee e2 ON e2.emp_no = e1.mgr_emp_no
                 INNER JOIN customer c ON e1.emp_no = c.emp_no
                 INNER JOIN salary_grade s ON e1.salary BETWEEN s.min_salary AND s.max_salary;

-- 99. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?
-- <조건> 담당직원이 없는 고객도 포함
SELECT c.cus_name, c.tel_num, e.emp_name, e.jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+);

-- 100. 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?
-- <조건> 고객정보는 모두 보이고 직원정보는 10번 부서만 보일 것
-- ORACLE JOIN
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND e.dep_no(+) = 10 ;

-- 100-1. 만약 e.dep_no(+) = 10 을 e.dep_no = 10으로 수정하면?
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND e.dep_no = 10 ;

-- ANSI JOIN
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no AND e.dep_no = 10 ;
-- FROM employee e RIGHT OUTER JOIN customer c ON e.emp_no = c.emp_no AND e.dep_no = 10;

-- 100-2. 만약 e.dep_no = 10를 따로 빼내서 WHERE e.dep_no = 10 로 추가하면?
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no
WHERE e.dep_no = 10 ;

-- 101. 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급, 담당직원연봉등급을 출력하면?
-- <조건> 담당직원이 없는 고객도 포함
SELECT c.cus_no       고객번호
        , c.cus_name  고객명
        , c.tel_num   고객전화번호
        , e.emp_name  담당직원명
        , e.jikup     담당직원직급
        , s.sal_grade_no 담당직원연봉등급
FROM customer c, employee e, salary_grade s
WHERE c.emp_no = e.emp_no(+) AND e.salary BETWEEN s.min_salary(+) AND s.max_salary(+)
ORDER BY c.cus_no;

-- 102. 고객번호, 고객명, 고객주민번호를 출력하라.
-- 단, 연봉이 3000 이상인 담당직원이 담당한 고객 이어야 한다.
SELECT c.cus_no 고객번호, c.cus_name 고객명, c.jumin_num 고객주민번호
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.salary >= 3000;

-- 103. 고객번호, 고객명, 고객주민번호를 출력하라.
-- 단, 40살 이상인 담당직원이 담당한 고객 이어야 한다.
SELECT c.cus_no 고객번호, c.cus_name 고객명, c.jumin_num 고객주민번호
FROM customer c, employee e
WHERE c.emp_no = e.emp_no
        AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
            - TO_NUMBER(
                DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                || SUBSTR(e.jumin_num, 1, 2)) + 1 >= 40;

--