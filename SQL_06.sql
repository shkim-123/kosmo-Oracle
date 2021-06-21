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
ORDER BY emp_name;

-- ANSI JOIN
SELECT e.emp_name, e.jikup, d.dep_name, c.cus_name, c.tel_num
FROM employee e INNER JOIN dept d ON d.dep_no = e.dep_no
                INNER JOIN customer c ON e.emp_no = c.emp_no
ORDER BY emp_name;