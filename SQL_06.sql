-- 90. ������ȣ, ������, �ҼӺμ��� �˻�?
-- ORACLE INNER JOIN
-- ���̺� ��Ī�� ���� �ʰ� ������ ��
SELECT employee.emp_no, employee.emp_name, dept.dep_name
FROM employee, dept
WHERE employee.dep_no = dept.dep_no;

-- ���̺� ��Ī�� �ְ� ������ �� (�����)
SELECT e.emp_no, e.emp_name, d.dep_name
FROM employee e, dept d
WHERE e.dep_no = d.dep_no;

-- ANSI INNER JOIN
SELECT e.emp_no, e.emp_name, d.dep_name
FROM employee e INNER JOIN dept d
ON e.dep_no = d.dep_no;

-- 91. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�?
-- <����> ��������� �ִ� ���� ���
-- ORACLE JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no;

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e
ON c.emp_no = e.emp_no;

-- 92. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�?
-- <����> 10�� �μ��� ��������� �ִ� ���� ���
-- ORACLE JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND dep_no = 10;

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e
ON c.emp_no = e.emp_no
WHERE dep_no = 10;

-- 93. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�?
-- <����> ������ 3000���� �̻��� ��������� �ִ� ���� ����
-- ORACLE JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND salary >= 3000;

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e
ON c.emp_no = e.emp_no
WHERE salary >= 3000;

-- 94. ������, ��������, �����μ���, ������, ����ȭ�� ����ϸ�?
-- <����> ���� �̸� �������� ����
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