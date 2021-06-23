-- 108. �ְ� ������ �޴� ������ �˻��϶�
SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

-- 109. ��� ���� �̻��� �޴� ������ �˻��϶�
SELECT *
FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee);

-- 110. 20�� �μ����� �ְ� ������ ������ �˻��϶�
SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee WHERE dep_no = 20) AND dep_no = 20;

-- 111. ������, ����, ����, ��ü�������� �����ϴ� ������ �˻��϶�.
-- ��ü�������� �����ϴ� ������ �Ҽ��� �����ϰ� %�� ǥ���϶�.
-- ��, ���� ������ ���� ������ �����϶�.
SELECT emp_name   ������
        , jikup   ����
        , salary  ����
        , FLOOR(salary/(SELECT SUM(salary) FROM employee)*100)||'%'  ����
FROM employee
ORDER BY salary/(SELECT SUM(salary) FROM employee)*100 DESC;

-- 112. 10�� �μ� �������� �����ϴ� ����ȣ, ����, ������ȣ�� �˻��ϸ�?
-- ���� ����
SELECT cus_no, cus_name, emp_no
FROM customer
WHERE emp_no = ANY(SELECT emp_no FROM employee WHERE dep_no = 10);
-- WHERE emp_no IN(SELECT emp_no FROM employee WHERE dep_no = 10);

-- JOIN�� ���
SELECT c.cus_no, c.cus_name, c.emp_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.dep_no = 10;

-- �������
SELECT cus_no, cus_name, emp_no
FROM customer c
WHERE (SELECT dep_no FROM employee e WHERE c.emp_no = e.emp_no) = 10;
-- WHERE (SELECT COUNT(*) FROM employee e WHERE c.emp_no = e.emp_no AND e.dep_no = 10) > 0;

-- 113. ��� ���� �̻��̰� �ִ� ���� �̸���
-- ������, ����, ��ü��տ���, ��ü�ִ뿬���� ����ϸ�?
SELECT emp_name   ������
        , salary  ����
        , (SELECT AVG(salary) FROM employee)  ��ü��տ���
        , (SELECT MAX(salary) FROM employee)  ��ü�ִ뿬��
FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee)
        AND salary < (SELECT MAX(salary) FROM employee);

-- 114. �ְ� ���� ������ ������ȣ, ������, �μ���, ������ �˻��ϸ�?
SELECT emp_no, emp_name, dep_name, salary
FROM employee e, dept d
WHERE salary = (SELECT MAX(salary) FROM employee)
        AND e.dep_no = d.dep_no;

-- 115. ��� ���� 2�� �̻��� ������ȣ, ������, ������ �˻��ϸ�?
SELECT e.emp_no, e.emp_name, e.jikup
FROM  employee e
WHERE (SELECT COUNT(*) FROM customer c WHERE e.emp_no = c.emp_no) >= 2;

-- 116. ������ȣ, ������, �ҼӺμ����� �˻��ϸ�?
-- ����
SELECT e.emp_no ������ȣ
        , e.emp_name ������
        , d.dep_name �μ���
FROM employee e, dept d
WHERE e.dep_no = d.dep_no;

-- �������� / ��� ����
SELECT emp_no       ������ȣ
        , emp_name  ������
        , (SELECT dep_name FROM dept d WHERE e.dep_no = d.dep_no)  �ҼӺμ���
FROM employee e;

-- 117. ������ȣ, ������, ����, ���� ������ ����ϸ�? ��, ���� ������ �������� ����
SELECT emp_no           ������ȣ
        , emp_name      ������
        , salary        ����
        , (SELECT COUNT(*) + 1 FROM employee e2 WHERE e1.salary < e2.salary) ��������
FROM employee e1
ORDER BY 4;

-- 118. ������ȣ, ������, �������� ����ϸ�?
SELECT emp_no       ������ȣ
        , emp_name  ������
        , (SELECT COUNT(*) FROM customer c WHERE c.emp_no = e.emp_no) ������
FROM employee e
ORDER BY 3 DESC;

-- 119. �μ���, �μ�������, �μ��������� ����ϸ�?
-- SUBQUERY / ORACLE JOIN
SELECT d.dep_name       �μ���
        , (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no) �μ�������
        , (SELECT COUNT(*) FROM employee e, customer c
            WHERE d.dep_no = e.dep_no AND e.emp_no = c.emp_no) �μ�������
FROM dept d
ORDER BY 2 DESC;

-- SUBQUERY / ANSI JOIN
SELECT d.dep_name       �μ���
        , (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no) �μ�������
        , (SELECT COUNT(*) FROM employee e INNER JOIN customer c
            ON e.emp_no = c.emp_no WHERE d.dep_no = e.dep_no) �μ�������
FROM dept d
ORDER BY 2 DESC;

-- ���̺� ����
UPDATE employee SET dep_no = 40 WHERE emp_no = 2;
COMMIT;

-- 120. ������ȣ, ������, ����, �ֹι�ȣ, ���޼��������� ����ϸ�?
-- ��, ������ ������ ���� ���� ������ ���޼������� �̴�.
-- �׸��� ���޼��������� �������� ����
-- 210622 Ǯ��
SELECT emp_no          ������ȣ
        , emp_name     ������
        , jikup        ����
        , jumin_num    �ֹι�ȣ
        , (SELECT COUNT(*) + 1 FROM employee e2
            WHERE
                CASE  -- ���� ���� ���� ���
                    WHEN e1.jikup <> e2.jikup
                    THEN DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
                END > DECODE(e2.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
                OR
                CASE    -- ���� ���� ���
                    WHEN e1.jikup = e2.jikup
                    THEN DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                || SUBSTR(e1.jumin_num, 1, 6)
                END  >  DECODE(SUBSTR(e2.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                || SUBSTR(e2.jumin_num, 1, 6)
            ) ���޼�������
FROM employee e1
ORDER BY 5;

-- 210623 Ǯ��(CASE�� ����)
SELECT emp_no          ������ȣ
        , emp_name     ������
        , jikup        ����
        , jumin_num    �ֹι�ȣ
        , (SELECT COUNT(*) + 1 FROM employee e2
            WHERE DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
                 > DECODE(e2.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
                OR (e1.jikup = e2.jikup
                    AND TO_NUMBER(DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                || SUBSTR(e1.jumin_num, 1, 6))
                        > TO_NUMBER(DECODE(SUBSTR(e2.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                || SUBSTR(e2.jumin_num, 1, 6))
                  )
            ) ���޼�������
FROM employee e1
ORDER BY 5;


-- ���ޱ����� ����
SELECT emp_no          ������ȣ
        , emp_name     ������
        , jikup        ����
        , jumin_num    �ֹι�ȣ
        , (SELECT COUNT(*)+1 FROM employee e2
                    WHERE DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
                        > DECODE(e2.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
            ) ���޼�������
FROM employee e1
ORDER BY 5;


-- 121. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, �μ���ȣ�� ����ϸ�?
-- <����> ��������� ���� ���� ����.
-- ��, ������ ������� ���� ���������� ����Ͻʽÿ�.
-- SUBQUERY
SELECT cus_no          ����ȣ
        , cus_name     ����
        , tel_num      ����ȭ��ȣ
        , (SELECT emp_name FROM employee e WHERE c.emp_no = e.emp_no)  ���������
        , (SELECT jikup FROM employee e WHERE c.emp_no = e.emp_no)     �����������
        , (SELECT dep_no FROM employee e WHERE c.emp_no = e.emp_no)    �μ���ȣ
FROM customer c;

-- ORACLE JOIN
SELECT cus_no, cus_name, tel_num, emp_name, jikup, dep_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+);

-- ANSI JOIN
SELECT cus_no, cus_name, tel_num, emp_name, jikup, dep_no
FROM customer c LEFT OUTER JOIN employee e
    ON c.emp_no = e.emp_no;

-- 122. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, �μ���ȣ�� ����ϸ�?
-- <����>�������� ��� ���̰� ���������� 10�� �μ��� ���� ��.
-- ��, ������ ������� ���� ���������� ����Ͻʽÿ�.
-- SUBQUERY
SELECT c.cus_no       ����ȣ
        , c.cus_name  ����
        , c.tel_num   ����ȭ��ȣ
        , (SELECT e.emp_name FROM employee e WHERE e.emp_no = c.emp_no AND e.dep_no = 10) ���������
        , (SELECT e.jikup FROM employee e WHERE e.emp_no = c.emp_no AND e.dep_no = 10)    �����������
        , (SELECT e.dep_no FROM employee e WHERE e.emp_no = c.emp_no AND e.dep_no = 10)   �μ���ȣ
FROM customer c
ORDER BY 1;

-- ORACLE JOIN
SELECT cus_no, cus_name, tel_num, emp_name, jikup, dep_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND e.dep_no(+) = 10
ORDER BY 1;

-- ANSI JOIN
SELECT cus_no, cus_name, tel_num, emp_name, jikup, dep_no
FROM customer c LEFT OUTER JOIN employee e
        ON c.emp_no = e.emp_no AND e.dep_no = 10
ORDER BY 1;