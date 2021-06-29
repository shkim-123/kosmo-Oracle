-- 146. employee ���̺�κ��� salary �÷��� �����ϰ� �� �� �� �ִ� �� employee_vw1�� �����ϸ�?
CREATE VIEW employee_vw1 AS
SELECT emp_no, emp_name, dep_no, jikup, hire_date, jumin_num, phone, mgr_emp_no
FROM employee

-- �� �˻�
SELECT * FROM employee_vw1

-- 147. �μ���, ���޺� �μ���ȣ, �μ���, ����, ��տ����� ����ϴ� �� employee_vw3�� �����ϸ�?
CREATE VIEW employee_vw3 AS
SELECT d.dep_no, d.dep_name, e.jikup, ROUND(AVG(e.salary), 1)  "AVG_SALARY"
FROM dept d, employee e
WHERE d.dep_no = e.dep_no
GROUP BY d.dep_no, d.dep_name, e.jikup

-- �� �˻�
SELECT * FROM employee_vw3

-- 147. �� employee_vw1�� ������ '�̽¿�', 40, '����', '1990-09-01', '7811231452719', '01090056376', 1 �� �Է��ϸ�?
INSERT INTO employee_vw1(emp_no, emp_name, dep_no, jikup, hire_date, jumin_num, phone, mgr_emp_no)
VALUES((SELECT NVL(MAX(emp_no), 0) + 1 FROM employee_vw1)
, '�̽¿�', 40, '����', TO_DATE('1990-09-01', 'YYYY-MM-DD'), '7811231452719', '01090056376', 1);

COMMIT

-- 148. �� employee_vw1���� �ֹι�ȣ '7811231452719', ������ '�̽¿�'�� ������ �������� �����ϸ�?
UPDATE employee_vw1 SET jikup = '����'
WHERE jumin_num = '7811231452719' AND emp_name = '�̽¿�';

SELECT * FROM employee
SELECT * FROM employee_vw1;

-- 149. �� employee_vw1���� �ֹι�ȣ '7811231452719' �� ������ �����ϸ�?
DELETE FROM employee_vw1 WHERE jumin_num = '7811231452719';

-- 150. �� employee_vw1 �� �����ϸ�?
DROP VIEW employee_vw1;

-- 152. ���� �信 ���� ������ ����ϸ�?
INSERT INTO dept VALUES(60, '������', '�λ�');

CREATE VIEW dept_vw1 AS
SELECT dep_no, dep_name, loc FROM dept
WHERE dep_no = 60 WITH CHECK OPTION;


SELECT * FROM dept_vw1

INSERT INTO dept_vw1 VALUES(70, '�̷���', '�뱸');


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

-- 156. employee ���̺� '�庸��', 40, '�븮', 3500, '2012-05-28', '8311091109310', '01092499215', 3 �����͸� �Է��ϸ�?
-- �������� ����Ͽ� PK ���� �Է� ��
INSERT INTO employee(emp_no, emp_name, dep_no, jikup, salary, hire_date, jumin_num, phone, mgr_emp_no)
VALUES(emp_sq.nextval, '�庸��', 40, '�븮', 3500, TO_DATE('2012-05-28', 'YYYY-MM-DD'), '8311091109310', '01092499215', 3);

-- ���������� ����Ͽ� PK ���� �Է� ��
INSERT INTO employee(emp_no, emp_name, dep_no, jikup, salary, hire_date, jumin_num, phone, mgr_emp_no)
VALUES((SELECT NVL(MAX(emp_no), 0) + 1 FROM employee)
    , '�庸��', 40, '�븮', 3500, TO_DATE('2012-05-28', 'YYYY-MM-DD'), '8311091109310', '01092499215', 3);

SELECT * FROM employee --> INSERT Ȯ��
COMMIT;                --> INSERT �۾� ����. INSERT �۾� ��� �� ROLLBACK; ����

-- 157. employee ���̺��� ���� ��ȣ�� 18�� �̰�, �ֹι�ȣ '8203121977315'�� '������' ������ ������ '����'���� �����Ϸ���?
-- 1) �ֹι�ȣ�� ã�Ƽ� ������ ��� ��
UPDATE employee SET jikup = '����' WHERE jumin_num = '8203121977315';
-- 2) PK�� ã�Ƽ� ������ ��� ��
UPDATE employee SET jikup = '����' WHERE emp_no = 18;

UPDATE employee SET jikup = '����' WHERE emp_name = '������' AND jumin_num = '8203121977315';

-- 157-1. ���� ������ ������ 500���� �λ��ϴ� UPDATE ����?
UPDATE employee SET salary = salary+500
WHERE SUBSTR(jumin_num, 7, 1) IN('2', '4') ;

UPDATE employee SET salary = salary+500
WHERE jumin_num LIKE '______2%' OR jumin_num LIKE '______4%' ;

UPDATE employee SET salary = salary+500
WHERE SUBSTR(jumin_num, 7, 1) = ANY('2', '4') ;

SELECT * FROM employee

-- 159. employee ���̺��� ��� ���� �̻��� ���� ������ 2% �谨�ϸ�?
UPDATE employee SET salary = salary*0.98
WHERE salary >= (SELECT AVG(salary) FROM employee)

-- 160. employee ���̺��� ��� ���� ���� ���� �������� ������ 50���� �λ��ϸ�?
UPDATE employee SET salary = salary + 50
WHERE salary < (SELECT AVG(salary) FROM employee)

-- 161. ��� ���� �ִ� ������ �޿��� 5% �λ��ϸ�?
UPDATE employee SET salary = salary*1.05
WHERE emp_no IN(SELECT DISTINCT emp_no FROM customer WHERE emp_no IS NOT NULL)

UPDATE employee SET salary = salary*1.05
WHERE emp_no = ANY(SELECT DISTINCT emp_no FROM customer WHERE emp_no IS NOT NULL)

-- 162. ���� ���� 2~5������ 5���� ������ 10% �����ϸ�?
-- ���� ���� �� �������� ���� > ���� ���� ���� > �Ի��� ���� ���� > ���� ���� ����
-- ���� Ǭ��, ����~~
UPDATE employee SET salary = salary*0.9
WHERE emp_no = ANY(
  SELECT asd.emp_no FROM
      (SELECT ROWNUM "RNUM", zxc.emp_no FROM (
          SELECT emp_no,
              (SELECT COUNT(*)+1 FROM employee e2
                  WHERE (e1.salary < e2.salary)
                      OR ((e1.salary = e2.salary)
                         AND (DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, '����', 5, 6)
                                  > DECODE(e2.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, '����', 5, 6) ))
                      OR ( (e1.salary = e2.salary) AND (e1.jikup = e2.jikup) AND (e1.hire_date > e2.hire_date))
                      OR ( (e1.salary = e2.salary) AND (e1.jikup = e2.jikup) AND (e1.hire_date = e2.hire_date)
                          AND (DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 6)
                                  > DECODE(SUBSTR(e2.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e2.jumin_num, 1, 6) ))
              )  "EMP_RANK"
          FROM employee e1
          ORDER BY emp_rank
      ) zxc WHERE ROWNUM <= 5     -- 5�����
  ) asd WHERE asd.rnum >= 2     -- 2�����
)

-- ����
UPDATE employee SET salary = salary*0.9
WHERE emp_no IN (
    SELECT emp_no FROM ( SELECT ROWNUM "RNUM", zxcv.* FROM (
        SELECT emp_no FROM employee
        ORDER BY salary DESC
                , DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, '����', 5, 6)
                , hire_date
                , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)
    ) zxcv WHERE ROWNUM <= 5 ) WHERE RNUM >= 2
)

SELECT * FROM employee

-- 163. employee�� �Ȱ��� ������ �Ȱ��� �����͸� ���� �ֵ��� ���̺� employee2 �����?
CREATE TABLE employee2 AS SELECT * FROM employee;

-- 164. employee�� �Ȱ��� ������ ���� �ֵ��� ���̺� employee3�� ����� �����ʹ� ������ ���� ��������?
CREATE TABLE employee3 AS SELECT * FROM employee WHERE 1=2

SELECT * FROM employee3