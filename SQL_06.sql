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
ORDER BY e.emp_name;

-- ANSI JOIN
SELECT e.emp_name, e.jikup, d.dep_name, c.cus_name, c.tel_num
FROM (employee e INNER JOIN dept d ON d.dep_no = e.dep_no)
                INNER JOIN customer c ON e.emp_no = c.emp_no
ORDER BY e.emp_name;

-- 95. ������, ��������, �ҼӺμ���, ��������� ����ϸ�?
-- ������� ��������, ���޳������� ��������, ���̳������� ���� ���� ���
-- ORACLE JOIN
SELECT e.emp_name, e.jikup, d.dep_name, s.sal_grade_no
FROM employee e, dept d, salary_grade s
WHERE e.dep_no = d.dep_no AND e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY s.sal_grade_no, DECODE(e.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
        , DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '1', '19', '20')
                ||SUBSTR(e.jumin_num, 1, 6);

-- ANSI JOIN
SELECT e.emp_name, e.jikup, d.dep_name, s.sal_grade_no
FROM employee e INNER JOIN dept d ON e.dep_no = d.dep_no
        INNER JOIN salary_grade s ON e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY s.sal_grade_no, DECODE(e.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
        , DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '1', '19', '20')
                ||SUBSTR(e.jumin_num, 1, 6);

-- 96. ����������, ������������, ���ӻ����, ���ӻ�������� ����ϸ�?
-- <����> ����� �ִ� ������ ����
-- ORACLE JOIN
SELECT e1.emp_name ����������, e1.jikup ������������
     , e2.emp_name ���ӻ����, e2.jikup ���ӻ������
FROM employee e1, employee e2
WHERE e1.mgr_emp_no = e2.emp_no;

-- ANSI JOIN
SELECT e1.emp_name ����������, e1.jikup ������������
      , e2.emp_name ���ӻ����, e2.jikup ���ӻ������
FROM employee e1 INNER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no;

-- 97. ���ӻ����, ���ӻ������, ����������, �������������� ����ϸ�?
-- <����> ����� �ִ� ������ ����
-- ORACLE JOIN
SELECT e1.emp_name ���ӻ����, e1.jikup ���ӻ������
        , e2.emp_name ����������, e2.jikup ������������
FROM employee e1, employee e2
WHERE e1.emp_no = e2.mgr_emp_no;

-- ANSI JOIN
SELECT e1.emp_name ���ӻ����, e1.jikup ���ӻ������
        , e2.emp_name ����������, e2.jikup ������������
FROM employee e1 INNER JOIN employee e2 ON e1.emp_no = e2.mgr_emp_no;

-- 98. ������, ��������, �ҼӺμ���, �������, ���ӻ����, ���ӻ������, �������� ����ϸ�?
-- ORACLE JOIN
SELECT e1.emp_name       ������
        , e1.jikup       ��������
        , d.dep_name     �ҼӺμ���
        , s.sal_grade_no   �������
        , e2.emp_name      ���ӻ����
        , e2.jikup         ���ӻ������
        , c.cus_name     ������
FROM employee e1, dept d, employee e2, customer c, salary_grade s
WHERE e1.dep_no = d.dep_no
        AND e2.emp_no = e1.mgr_emp_no
        AND e1.salary BETWEEN s.min_salary AND s.max_salary
        AND e1.emp_no = c.emp_no ;

-- ANSI JOIN
SELECT e1.emp_name       ������
        , e1.jikup       ��������
        , d.dep_name     �ҼӺμ���
        , s.sal_grade_no   �������
        , e2.emp_name      ���ӻ����
        , e2.jikup         ���ӻ������
        , c.cus_name     ������
FROM employee e1 INNER JOIN dept d ON e1.dep_no = d.dep_no
                 INNER JOIN employee e2 ON e2.emp_no = e1.mgr_emp_no
                 INNER JOIN customer c ON e1.emp_no = c.emp_no
                 INNER JOIN salary_grade s ON e1.salary BETWEEN s.min_salary AND s.max_salary;

-- 99. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�?
-- <����> ��������� ���� ���� ����
SELECT c.cus_name, c.tel_num, e.emp_name, e.jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+);

-- 100. ����ȣ, ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�?
-- <����> �������� ��� ���̰� ���������� 10�� �μ��� ���� ��
-- ORACLE JOIN
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND e.dep_no(+) = 10 ;

-- 100-1. ���� e.dep_no(+) = 10 �� e.dep_no = 10���� �����ϸ�?
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND e.dep_no = 10 ;

-- ANSI JOIN
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no AND e.dep_no = 10 ;
-- FROM employee e RIGHT OUTER JOIN customer c ON e.emp_no = c.emp_no AND e.dep_no = 10;

-- 100-2. ���� e.dep_no = 10�� ���� ������ WHERE e.dep_no = 10 �� �߰��ϸ�?
SELECT c.cus_no, c.cus_name, c.tel_num, e.emp_name, e.jikup, e.dep_no
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no
WHERE e.dep_no = 10 ;

-- 101. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, ���������������� ����ϸ�?
-- <����> ��������� ���� ���� ����
SELECT c.cus_no       ����ȣ
        , c.cus_name  ����
        , c.tel_num   ����ȭ��ȣ
        , e.emp_name  ���������
        , e.jikup     �����������
        , s.sal_grade_no ��������������
FROM customer c, employee e, salary_grade s
WHERE c.emp_no = e.emp_no(+) AND e.salary BETWEEN s.min_salary(+) AND s.max_salary(+)
ORDER BY c.cus_no;

-- 102. ����ȣ, ����, ���ֹι�ȣ�� ����϶�.
-- ��, ������ 3000 �̻��� ��������� ����� �� �̾�� �Ѵ�.
SELECT c.cus_no ����ȣ, c.cus_name ����, c.jumin_num ���ֹι�ȣ
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.salary >= 3000;

-- 103. ����ȣ, ����, ���ֹι�ȣ�� ����϶�.
-- ��, 40�� �̻��� ��������� ����� �� �̾�� �Ѵ�.
-- ORACLE JOIN
SELECT c.cus_no ����ȣ, c.cus_name ����, c.jumin_num ���ֹι�ȣ
FROM customer c, employee e
WHERE c.emp_no = e.emp_no
        AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
            - TO_NUMBER(
                DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                || SUBSTR(e.jumin_num, 1, 2)) + 1 >= 40;

-- EXTRACT() �Լ� ���
SELECT c.cus_no ����ȣ, c.cus_name ����, c.jumin_num ���ֹι�ȣ
FROM customer c, employee e
WHERE c.emp_no = e.emp_no
        AND ( EXTRACT(YEAR FROM SYSDATE)
                - EXTRACT(YEAR FROM TO_DATE(
                    DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                        || SUBSTR(e.jumin_num, 1, 6), 'YYYYMMDD')) + 1 ) >= 40;

-- ANSI JOIN
SELECT c.cus_no ����ȣ, c.cus_name ����, c.jumin_num ���ֹι�ȣ
FROM customer c INNER JOIN employee e
ON c.emp_no = e.emp_no
        AND TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
            - TO_NUMBER(
                DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                || SUBSTR(e.jumin_num, 1, 2)) + 1 >= 40;

--  104. ����ȣ, ����, ���������ȣ, ���������, ��������ҼӺμ���
-- , ��������������, ����������ӻ����, ����������ӻ������, ���ӻ��������� ����϶�.
-- ��, ���� �� ���;� �ϰ� NULL�� �������� ǥ��
-- ORACLE JOIN
SELECT c.cus_no       ����ȣ
        , c.cus_name  ����
        , NVL(c.emp_no||'', '����')     ���������ȣ
        , NVL(e1.emp_name, '����')      ���������
        , NVL(d.dep_name, '����')        ��������ҼӺμ���
        , NVL(s1.sal_grade_no||'', '����')  ��������������
        , NVL(e2.emp_name, '����')         ����������ӻ����
        , NVL(e2.jikup, '����')            ����������ӻ������
        , NVL(s2.sal_grade_no||'', '����') ���ӻ���������
FROM customer c, employee e1, dept d, salary_grade s1, employee e2, salary_grade s2
WHERE c.emp_no = e1.emp_no(+) AND e1.dep_no = d.dep_no(+)
        AND e1.salary BETWEEN s1.min_salary(+) AND s1.max_salary(+)
        AND e1.mgr_emp_no = e2.emp_no(+)
        AND e2.salary BETWEEN s2.min_salary(+) AND s2.max_salary(+)
ORDER BY c.cus_no;

-- ANSI JOIN
SELECT c.cus_no       ����ȣ
        , c.cus_name  ����
        , NVL(c.emp_no||'', '����')     ���������ȣ
        , NVL(e1.emp_name, '����')      ���������
        , NVL(d.dep_name, '����')        ��������ҼӺμ���
        , NVL(s1.sal_grade_no||'', '����')  ��������������
        , NVL(e2.emp_name, '����')         ����������ӻ����
        , NVL(e2.jikup, '����')            ����������ӻ������
        , NVL(s2.sal_grade_no||'', '����') ���ӻ���������
FROM customer c LEFT OUTER JOIN employee e1 ON c.emp_no = e1.emp_no
                LEFT OUTER JOIN dept d ON e1.dep_no = d.dep_no
                LEFT OUTER JOIN salary_grade s1 ON e1.salary BETWEEN s1.min_salary AND s1.max_salary
                LEFT OUTER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
                LEFT OUTER JOIN salary_grade s2 ON e2.salary BETWEEN s2.min_salary AND s2.max_salary
ORDER BY c.cus_no;