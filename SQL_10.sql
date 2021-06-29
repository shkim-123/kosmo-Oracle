-- 146. employee 테이블로부터 salary 컬럼만 제외하고 다 볼 수 있는 뷰 employee_vw1를 생성하면?
CREATE VIEW employee_vw1 AS
SELECT emp_no, emp_name, dep_no, jikup, hire_date, jumin_num, phone, mgr_emp_no
FROM employee

-- 뷰 검색
SELECT * FROM employee_vw1

-- 147. 부서별, 직급별 부서번호, 부서명, 직급, 평균연봉을 출력하는 뷰 employee_vw3를 생성하면?
CREATE VIEW employee_vw3 AS
SELECT d.dep_no, d.dep_name, e.jikup, ROUND(AVG(e.salary), 1)  "AVG_SALARY"
FROM dept d, employee e
WHERE d.dep_no = e.dep_no
GROUP BY d.dep_no, d.dep_name, e.jikup

-- 뷰 검색
SELECT * FROM employee_vw3

-- 147. 뷰 employee_vw1에 데이터 '이승엽', 40, '과장', '1990-09-01', '7811231452719', '01090056376', 1 를 입력하면?
INSERT INTO employee_vw1(emp_no, emp_name, dep_no, jikup, hire_date, jumin_num, phone, mgr_emp_no)
VALUES((SELECT NVL(MAX(emp_no), 0) + 1 FROM employee_vw1)
, '이승엽', 40, '과장', TO_DATE('1990-09-01', 'YYYY-MM-DD'), '7811231452719', '01090056376', 1);

COMMIT

-- 148. 뷰 employee_vw1에서 주민번호 '7811231452719', 직원명 '이승엽'의 직급을 부장으로 수정하면?
UPDATE employee_vw1 SET jikup = '부장'
WHERE jumin_num = '7811231452719' AND emp_name = '이승엽';

SELECT * FROM employee
SELECT * FROM employee_vw1;

-- 149. 뷰 employee_vw1에서 주민번호 '7811231452719' 인 직원을 제거하면?
DELETE FROM employee_vw1 WHERE jumin_num = '7811231452719';

-- 150. 뷰 employee_vw1 를 제거하면?
DROP VIEW employee_vw1;

-- 152. 다음 뷰에 대한 질문에 대답하면?
INSERT INTO dept VALUES(60, '전략부', '부산');

CREATE VIEW dept_vw1 AS
SELECT dep_no, dep_name, loc FROM dept
WHERE dep_no = 60 WITH CHECK OPTION;


SELECT * FROM dept_vw1

INSERT INTO dept_vw1 VALUES(70, '미래부', '대구');


CREATE VIEW employee_vw6 AS
    SELECT emp_no, emp_name, dep_no, jikup, salary FROM employee WHERE salary >= 3000
WITH CHECK OPTION;

SELECT * FROM employee_vw6

UPDATE employee_vw6 SET salary = salary*0.95 WHERE salary >= 3000


CREATE VIEW employee_vw7 AS
		SELECT emp_no, emp_name, dep_no, jikup, salary
		FROM employee WHERE salary >= 3000 WITH CHECK OPTION;

SELECT * FROM employee_vw7;

UPDATE employee_vw7 SET salary = salary*0.95 WHERE salary >= 3100;

SELECT view_name, text FROM user_views;

SELECT * FROM employee_vw3

-- 156. employee 테이블에 '장보고', 40, '대리', 3500, '2012-05-28', '8311091109310', '01092499215', 3 데이터를 입력하면?
-- 시퀀스를 사용하여 PK 값을 입력 예
INSERT INTO employee(emp_no, emp_name, dep_no, jikup, salary, hire_date, jumin_num, phone, mgr_emp_no)
VALUES(emp_sq.nextval, '장보고', 40, '대리', 3500, TO_DATE('2012-05-28', 'YYYY-MM-DD'), '8311091109310', '01092499215', 3);

-- 서브쿼리를 사용하여 PK 값을 입력 예
INSERT INTO employee(emp_no, emp_name, dep_no, jikup, salary, hire_date, jumin_num, phone, mgr_emp_no)
VALUES((SELECT NVL(MAX(emp_no), 0) + 1 FROM employee)
    , '장보고', 40, '대리', 3500, TO_DATE('2012-05-28', 'YYYY-MM-DD'), '8311091109310', '01092499215', 3);

SELECT * FROM employee --> INSERT 확인
COMMIT;                --> INSERT 작업 인정. INSERT 작업 취소 시 ROLLBACK; 실행

-- 157. employee 테이블에서 직원 번호가 18번 이고, 주민번호 '8203121977315'인 '강감찬' 직원의 직급을 '주임'으로 수정하려면?
-- 1) 주민번호로 찾아서 수정한 경우 답
UPDATE employee SET jikup = '주임' WHERE jumin_num = '8203121977315';
-- 2) PK로 찾아서 수정한 경우 답
UPDATE employee SET jikup = '주임' WHERE emp_no = 18;

UPDATE employee SET jikup = '주임' WHERE emp_name = '강감찬' AND jumin_num = '8203121977315';

-- 157-1. 여성 직원의 월급을 500만원 인상하는 UPDATE 문은?
UPDATE employee SET salary = salary+500
WHERE SUBSTR(jumin_num, 7, 1) IN('2', '4') ;

UPDATE employee SET salary = salary+500
WHERE jumin_num LIKE '______2%' OR jumin_num LIKE '______4%' ;

UPDATE employee SET salary = salary+500
WHERE SUBSTR(jumin_num, 7, 1) = ANY('2', '4') ;

SELECT * FROM employee

-- 159. employee 테이블에서 평균 연봉 이상의 직원 연봉을 2% 삭감하면?
UPDATE employee SET salary = salary*0.98
WHERE salary >= (SELECT AVG(salary) FROM employee)

-- 160. employee 테이블에서 평균 연봉 보다 작은 연봉자의 연봉을 50만원 인상하면?
UPDATE employee SET salary = salary + 50
WHERE salary < (SELECT AVG(salary) FROM employee)

-- 161. 담당 고객이 있는 직원의 급여를 5% 인상하면?
UPDATE employee SET salary = salary*1.05
WHERE emp_no IN(SELECT DISTINCT emp_no FROM customer WHERE emp_no IS NOT NULL)

UPDATE employee SET salary = salary*1.05
WHERE emp_no = ANY(SELECT DISTINCT emp_no FROM customer WHERE emp_no IS NOT NULL)

-- 162. 연봉 서열 2~5위까지 5명의 연봉을 10% 인하하면?
-- 정렬 기준 → 연봉높은 순서 > 직급 높은 순서 > 입사일 빠른 순서 > 나이 높은 순서
-- 내가 푼거, 삽질~~
UPDATE employee SET salary = salary*0.9
WHERE emp_no = ANY(
  SELECT asd.emp_no FROM
      (SELECT ROWNUM "RNUM", zxc.emp_no FROM (
          SELECT emp_no,
              (SELECT COUNT(*)+1 FROM employee e2
                  WHERE (e1.salary < e2.salary)
                      OR ((e1.salary = e2.salary)
                         AND (DECODE(e1.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, 6)
                                  > DECODE(e2.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, 6) ))
                      OR ( (e1.salary = e2.salary) AND (e1.jikup = e2.jikup) AND (e1.hire_date > e2.hire_date))
                      OR ( (e1.salary = e2.salary) AND (e1.jikup = e2.jikup) AND (e1.hire_date = e2.hire_date)
                          AND (DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 6)
                                  > DECODE(SUBSTR(e2.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e2.jumin_num, 1, 6) ))
              )  "EMP_RANK"
          FROM employee e1
          ORDER BY emp_rank
      ) zxc WHERE ROWNUM <= 5     -- 5행까지
  ) asd WHERE asd.rnum >= 2     -- 2행부터
)

-- 정답
UPDATE employee SET salary = salary*0.9
WHERE emp_no IN (
    SELECT emp_no FROM ( SELECT ROWNUM "RNUM", zxcv.* FROM (
        SELECT emp_no FROM employee
        ORDER BY salary DESC
                , DECODE(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, 6)
                , hire_date
                , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)
    ) zxcv WHERE ROWNUM <= 5 ) WHERE RNUM >= 2
)

SELECT * FROM employee

-- 163. employee와 똑같은 구조와 똑같은 데이터를 가진 쌍둥이 테이블 employee2 만들면?
CREATE TABLE employee2 AS SELECT * FROM employee;

-- 164. employee와 똑같은 구조를 가진 쌍둥이 테이블 employee3를 만들되 데이터는 복사해 오지 않으려면?
CREATE TABLE employee3 AS SELECT * FROM employee WHERE 1=2

SELECT * FROM employee3