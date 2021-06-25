--90. 직원번호, 직원명, 소속부서명 검색?
SELECT emp_no, emp_name, dep_name
FROM employee e, dept d
WHERE e.dep_no = d.dep_no

SELECT emp_no, emp_name, dep_name
FROM employee e INNER JOIN dept d ON e.dep_no = d.dep_no
--91. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면? <조건> 담당직원이 있는 고객만 출력
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no

SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no
--92. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면? <조건> 10번 부서의 담당직원이 있는 고객만 출력
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND dep_no = 10

SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no
WHERE dep_no = 10;
--93. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면? <조건> 연봉이 3000만원 이상인 담당직원이 있는 고객만 포함
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.salary >= 3000

SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no
WHERE e.salary >= 3000
--94. 직원명, 직원직급, 직원부서명, 담당고객명, 고객전화를 출력하면? <조건> 직원 이름 오름차순 정렬
SELECT emp_name, jikup, dep_name, cus_name, tel_num
FROM employee e, customer c, dept d
WHERE e.emp_no = c.emp_no AND e.dep_no = d.dep_no
ORDER BY emp_name

SELECT emp_name, jikup, dep_name, cus_name, tel_num
FROM employee e INNER JOIN customer c ON e.emp_no = c.emp_no
                INNER JOIN dept d ON e.dep_no = d.dep_no
ORDER BY emp_name
--95. 직원명, 직원직급, 소속부서명, 연봉등급을 출력하면? 연봉등급 오름차순, 직급높은순서 오름차순, 나이높은순서 내림 유지 요망
SELECT emp_name, jikup, dep_name, sal_grade_no
FROM employee e, dept d, salary_grade s
WHERE e.dep_no = d.dep_no AND e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY sal_grade_no
        , DECODE(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)

SELECT emp_name, jikup, dep_name, sal_grade_no
FROM employee e INNER JOIN dept d ON e.dep_no = d.dep_no
                INNER JOIN salary_grade s ON e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY sal_grade_no
        , DECODE(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5)
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)
--96. 부하직원명, 부하직원직급, 직속상관명, 직속상관직급을 출력하면? <조건> 상관이 있는 직원만 포함
SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1, employee e2
WHERE e1.mgr_emp_no = e2.emp_no

SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1 INNER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
--97. 직속상관명, 직속상관직급, 부하직원명, 부하직원직급을 출력하면? <조건> 상관이 있는 직원만 포함
SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1, employee e2
WHERE e1.emp_no = e2.mgr_emp_no;

SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1 INNER JOIN employee e2 ON e1.emp_no = e2.mgr_emp_no
--98. 직원명, 직원직급, 소속부서명, 연봉등급, 직속상관명, 직속상관직급, 담당고객명을 출력하면?
SELECT e1.emp_name, e1.jikup, d.dep_name, s.sal_grade_no, e2.emp_name, e2.jikup, c.cus_name
FROM employee e1, employee e2, dept d, salary_grade s, customer c
WHERE e1.mgr_emp_no = e2.emp_no AND e1.dep_no = d.dep_no AND e1.salary BETWEEN s.min_salary AND s.max_salary  AND e1.emp_no = c.emp_no

SELECT e1.emp_name, e1.jikup, d.dep_name, s.sal_grade_no, e2.emp_name, e2.jikup, c.cus_name
FROM employee e1 INNER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
                 INNER JOIN dept d ON e1.dep_no = d.dep_no
                 INNER JOIN salary_grade s ON e1.salary BETWEEN s.min_salary AND s.max_salary
                 INNER JOIN customer c ON e1.emp_no = c.emp_no
--99. 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면? <조건> 담당직원이 없는 고객도 포함
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+)

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no
--100. 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면? <조건> 고객정보는 모두 보이고 직원정보는 10번 부서만 보일 것
SELECT cus_no, cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND dep_no(+) = 10

-- ANSI JOIN
SELECT cus_no, cus_name, tel_num, emp_name, jikup
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no AND dep_no = 10
--101. 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급, 담당직원연봉등급을 출력하면? <조건> 담당직원이 없는 고객도 포함
SELECT cus_no, cus_name, tel_num, emp_name, jikup, sal_grade_no
FROM customer c, employee e, salary_grade s
WHERE c.emp_no = e.emp_no(+) AND e.salary BETWEEN s.min_salary AND s.max_salary

-- ANSI JOIN
SELECT cus_no, cus_name, tel_num emp_name, jikup, sal_grade_no
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no
                LEFT OUTER JOIN salary_grade s ON e.salary BETWEEN s.min_salary AND s.max_salary

--102. 고객번호, 고객명, 고객주민번호를 출력하라. 단, 연봉이 3000 이상인 담당직원이 담당한 고객 이어야 한다.

--103. 고객번호, 고객명, 고객주민번호를 출력하라. 단, 40살 이상인 담당직원이 담당한 고객 이어야 한다.
--103-1. 10번 부서 또는 30번 부서 직원이 담당하는 고객을 검색하면?
--
--104. 고객번호, 고객명,
--담당직원번호,담당직원명, 담당직원소속부서명, 담당직원연봉등급, 담당직원직속상관명, 담당직원직속상관직급,
--직속상관연봉등급 출력하라. 단, 고객은 다 나와야 하고 NULL은 없음으로 표시
--
--
--105. 직원명, 직원전화번호 와 고객명, 고객전화번호를 종으로 붙여 출력하라. 조건은 중복하지 말 것
--106. 직원명, 직원전화번호 와 고객명, 고객전화번호를 종으로 붙여 출력하라. 조건은 중복허락
--108. 최고 연봉을 받는 직원을 검색하라
--109. 평균 연봉 이상을 받는 직원을 검색하라
--110. 20번 부서에서 최고 연봉자 직원을 검색하라
--
--111. 직원명, 직급, 연봉, 전체연봉에서 차지하는 비율을 검색하라. 단, 전체연봉에서 차지하는 비율은 소수점 버림하고 %로 표현하라.
--단, 높은 비율이 먼저 나오게 정렬하라.
--
--112. 10번 부서 직원들이 관리하는 고객번호, 고객명, 직원번호를 검색하면?
--113. 평균 연봉 이상이고 최대 연봉 미만의 직원명, 연봉, 전체평균연봉, 전체최대연봉을 출력하면?
--114. 최고 연봉 직원의 직원번호, 직원명, 부서명, 연봉을 검색하면?
--115. 담당 고객이 2명 이상인 직원번호, 직원명, 직급을 검색하면?
--116. 직원번호, 직원명, 소속부서명을 검색하면?
--117. 직원번호, 직원명, 연봉, 연봉 순위를 출력하면? 단, 연봉 순위를 오름차순 유지
--118. 직원번호, 직원명, 담당고객수를 출력하면?
--119. 부서명, 부서직원수, 부서담당고객수를 출력하면?
--
--120. 직원번호, 직원명, 직급, 주민번호, 직급서열순위를 출력하면?
--단, 직급이 같으면 나이 많은 직원이 직급서열순위 이다. 그리고 직급서열순위를 오름차순 유지
--
--121. 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급, 부서번호를 출력하면?
--<조건> 담당직원이 없는 고객도 포함. 단, 조인을 사용하지 말고 서브쿼리를 사용하십시오.
--
--122. 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급, 부서번호를 출력하면?
--<조건>고객정보는 모두 보이고 직원정보는 10번 부서만 보일 것. 단, 조인을 사용하지 말고 서브쿼리를 사용하십시오.
--
--124. 부서별로 부서번호, 급여합, 평균급여, 인원수를 출력하면? 단, 평균은 소수 둘째 자리에서 반올림 할 것
--125. 직급별로 직급, 급여합, 평균급여, 인원수를 출력하면? 단, 평균은 소수 둘째 자리에서 반올림 할 것
--126. 부서별, 직급별, 부서번호, 직급, 급여합, 평균급여, 인원수를 출력하면? 단, 평균은 소수 둘째 자리에서 반올림 할 것
--127. 부서별, 직급별, 부서번호, 직급, 급여합, 평균급여, 인원수를 출력하되 인원수는 3명 이상인 출력하면?
--128. 부서별, 성별로 부서번호, 성별, 급여합, 평균급여, 인원수를 출력하면?
--129. 입사년도별로 입사년도, 인원수를 출력하고 년도별로 오름차순 하면?
--130. 부서별로 부서번호, 평균근무년수를 출력하면? (근년수는 소수점 둘째 자리에서 반올림할 것)
--131. 입사분기별로 입사분기, 인원수를 출력하면?
--132. 입사연대별, 성별로 입사연대, 성별, 연대별입사자수 출력하면?
--
--133. 직원명, 입사일(년-월-일 ~/4분기 한글 1자리 요일), 퇴직일(년-월-일) 출력하면?
--<조건> 퇴직일은 입사 후 20년 5개월 10일 후
--
--134. 직원들이 있는 부서별로 부서번호, 부서위치, 직원수를 출력하면? 모든 부서 다 나와라
--
--135. 월별로 입사월, 인원수를 검색하면? 입사월 오름차순 유지 <조건> 입사월 오름차순 유지
--<조건> 위 결과에서 2월, 9월은 없어서 빠진다. 2월, 9월도 포함시키고 인원수는 0으로 포함하려면?
--
--136. employee 테이블에서 직급순서대로 정렬하여 직급별로 직급, 직급평균연봉, 인원수를 검색하면? (높은 직급이 먼저 나와야함)
--137. 부서별 부서번호, 부서명, 직원수, 직원이관리하는고객수를 검색하면?
--
--138. 퇴직일이 60세라는 기준 하에 아래처럼 출력하면?
--직원번호, 직원명, 근무년차, 퇴직일까지 남은 년도, 생일(년-월-일 요일명), 소속부서명, 직속상관명, 직속상관 부서명.
--단, 모든 직원 다 나오고, 직급 높은 사람이 먼저 나오고 직급이 같으면 나이가 많은 사람이 나와야함.
--
--
