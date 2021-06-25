--90. ������ȣ, ������, �ҼӺμ��� �˻�?
SELECT emp_no, emp_name, dep_name
FROM employee e, dept d
WHERE e.dep_no = d.dep_no

SELECT emp_no, emp_name, dep_name
FROM employee e INNER JOIN dept d ON e.dep_no = d.dep_no
--91. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�? <����> ��������� �ִ� ���� ���
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no

SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no
--92. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�? <����> 10�� �μ��� ��������� �ִ� ���� ���
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND dep_no = 10

SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no
WHERE dep_no = 10;
--93. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�? <����> ������ 3000���� �̻��� ��������� �ִ� ���� ����
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.salary >= 3000

SELECT cus_name, tel_num, emp_name, jikup
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no
WHERE e.salary >= 3000
--94. ������, ��������, �����μ���, ������, ����ȭ�� ����ϸ�? <����> ���� �̸� �������� ����
SELECT emp_name, jikup, dep_name, cus_name, tel_num
FROM employee e, customer c, dept d
WHERE e.emp_no = c.emp_no AND e.dep_no = d.dep_no
ORDER BY emp_name

SELECT emp_name, jikup, dep_name, cus_name, tel_num
FROM employee e INNER JOIN customer c ON e.emp_no = c.emp_no
                INNER JOIN dept d ON e.dep_no = d.dep_no
ORDER BY emp_name
--95. ������, ��������, �ҼӺμ���, ��������� ����ϸ�? ������� ��������, ���޳������� ��������, ���̳������� ���� ���� ���
SELECT emp_name, jikup, dep_name, sal_grade_no
FROM employee e, dept d, salary_grade s
WHERE e.dep_no = d.dep_no AND e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY sal_grade_no
        , DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)

SELECT emp_name, jikup, dep_name, sal_grade_no
FROM employee e INNER JOIN dept d ON e.dep_no = d.dep_no
                INNER JOIN salary_grade s ON e.salary BETWEEN s.min_salary AND s.max_salary
ORDER BY sal_grade_no
        , DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)
--96. ����������, ������������, ���ӻ����, ���ӻ�������� ����ϸ�? <����> ����� �ִ� ������ ����
SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1, employee e2
WHERE e1.mgr_emp_no = e2.emp_no

SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1 INNER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
--97. ���ӻ����, ���ӻ������, ����������, �������������� ����ϸ�? <����> ����� �ִ� ������ ����
SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1, employee e2
WHERE e1.emp_no = e2.mgr_emp_no;

SELECT e1.emp_name, e1.jikup, e2.emp_name, e2.jikup
FROM employee e1 INNER JOIN employee e2 ON e1.emp_no = e2.mgr_emp_no
--98. ������, ��������, �ҼӺμ���, �������, ���ӻ����, ���ӻ������, �������� ����ϸ�?
SELECT e1.emp_name, e1.jikup, d.dep_name, s.sal_grade_no, e2.emp_name, e2.jikup, c.cus_name
FROM employee e1, employee e2, dept d, salary_grade s, customer c
WHERE e1.mgr_emp_no = e2.emp_no AND e1.dep_no = d.dep_no AND e1.salary BETWEEN s.min_salary AND s.max_salary  AND e1.emp_no = c.emp_no

SELECT e1.emp_name, e1.jikup, d.dep_name, s.sal_grade_no, e2.emp_name, e2.jikup, c.cus_name
FROM employee e1 INNER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
                 INNER JOIN dept d ON e1.dep_no = d.dep_no
                 INNER JOIN salary_grade s ON e1.salary BETWEEN s.min_salary AND s.max_salary
                 INNER JOIN customer c ON e1.emp_no = c.emp_no
--99. ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�? <����> ��������� ���� ���� ����
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+)

-- ANSI JOIN
SELECT cus_name, tel_num, emp_name, jikup
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no
--100. ����ȣ, ����, ����ȭ��ȣ, ���������, ������������� ����ϸ�? <����> �������� ��� ���̰� ���������� 10�� �μ��� ���� ��
SELECT cus_no, cus_name, tel_num, emp_name, jikup
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND dep_no(+) = 10

-- ANSI JOIN
SELECT cus_no, cus_name, tel_num, emp_name, jikup
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no AND dep_no = 10
--101. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, ���������������� ����ϸ�? <����> ��������� ���� ���� ����
SELECT cus_no, cus_name, tel_num, emp_name, jikup, sal_grade_no
FROM customer c, employee e, salary_grade s
WHERE c.emp_no = e.emp_no(+) AND e.salary BETWEEN s.min_salary AND s.max_salary

-- ANSI JOIN
SELECT cus_no, cus_name, tel_num emp_name, jikup, sal_grade_no
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no
                LEFT OUTER JOIN salary_grade s ON e.salary BETWEEN s.min_salary AND s.max_salary

--102. ����ȣ, ����, ���ֹι�ȣ�� ����϶�. ��, ������ 3000 �̻��� ��������� ����� �� �̾�� �Ѵ�.
SELECT c.cus_no, c.cus_name, c.jumin_num
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.salary >= 3000

SELECT c.cus_no, c.cus_name, c.jumin_num
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no AND e.salary >= 3000
--103. ����ȣ, ����, ���ֹι�ȣ�� ����϶�. ��, 40�� �̻��� ��������� ����� �� �̾�� �Ѵ�.
SELECT c.cus_no, c.cus_name, c.jumin_num
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND EXTRACT(YEAR FROM SYSDATE)
            - TO_NUMBER(DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e.jumin_num, 1, 2)) + 1  > 40

-- ANSI JOIN
SELECT c.cus_no, c.cus_name, c.jumin_num
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no
        AND EXTRACT(YEAR FROM SYSDATE)
        - TO_NUMBER(DECODE(SUBSTR(e.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e.jumin_num, 1, 2)) + 1 >40
--103-1. 10�� �μ� �Ǵ� 30�� �μ� ������ ����ϴ� ���� �˻��ϸ�?
SELECT c.cus_name
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.dep_no IN (10, 30)

-- ANSI JOIN
SELECT c.cus_name
FROM customer c INNER JOIN employee e ON c.emp_no = e.emp_no AND e.dep_no IN (10, 30)
--
--104. ����ȣ, ����,
--���������ȣ,���������, ��������ҼӺμ���, ��������������, ����������ӻ����, ����������ӻ������,
--���ӻ��������� ����϶�. ��, ���� �� ���;� �ϰ� NULL�� �������� ǥ��
SELECT c.cus_no, c.cus_name, NVL(e1.emp_no||'', '����'), NVL(e1.emp_name, '����') , NVL(d.dep_name, '����'), NVL(s1.sal_grade_no||'', '����' )
        , NVL(e2.emp_name, '����'), NVL(e2.jikup, '����'), NVL(s2.sal_grade_no||'', '����')
FROM customer c, employee e1, dept d, salary_grade s1, employee e2, salary_grade s2
WHERE c.emp_no = e1.emp_no(+) AND e1.dep_no = d.dep_no(+) AND e1.salary BETWEEN s1.min_salary(+) AND s1.max_salary(+)
            AND e1.mgr_emp_no = e2.emp_no(+) AND e2.salary BETWEEN s2.min_salary(+) AND s2.max_salary(+)

SELECT c.cus_no, c.cus_name, NVL(e1.emp_no||'', '����'), NVL(e1.emp_name, '����'), NVL(d.dep_name, '����'), NVL(s1.sal_grade_no||'', '����')
        , NVL(e2.emp_name, '����'), nvl(e2.jikup, '����'), NVL(s2.sal_grade_no||'', '����')
FROM customer c LEFT OUTER JOIN employee e1 ON c.emp_no = e1.emp_no
                LEFT OUTER JOIN dept d ON e1.dep_no = d.dep_no
                LEFT OUTER JOIN salary_grade s1 ON e1.salary BETWEEN s1.min_salary AND s1.max_salary
                LEFT OUTER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
                LEFT OUTER JOIN salary_grade s2 ON e2.salary BETWEEN s2.min_salary AND s2.max_salary
--
--
--105. ������, ������ȭ��ȣ �� ����, ����ȭ��ȣ�� ������ �ٿ� ����϶�. ������ �ߺ����� �� ��
SELECT emp_name, phone
FROM employee
UNION
SELECT cus_name, tel_num
FROM customer
--106. ������, ������ȭ��ȣ �� ����, ����ȭ��ȣ�� ������ �ٿ� ����϶�. ������ �ߺ����
SELECT emp_name, phone
FROM employee
UNION ALL
SELECT cus_name, tel_num
FROM customer
--108. �ְ� ������ �޴� ������ �˻��϶�
SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee)
--109. ��� ���� �̻��� �޴� ������ �˻��϶�
SELECT *
FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee)
--110. 20�� �μ����� �ְ� ������ ������ �˻��϶�
SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee WHERE dep_no = 20) AND dep_no = 20;
--
--111. ������, ����, ����, ��ü�������� �����ϴ� ������ �˻��϶�. ��, ��ü�������� �����ϴ� ������ �Ҽ��� �����ϰ� %�� ǥ���϶�.
--��, ���� ������ ���� ������ �����϶�.
SELECT emp_name, jikup, salary, FLOOR((salary/(SELECT SUM(salary) FROM employee))*100)||'%'
FROM employee
ORDER BY (salary/(SELECT SUM(salary) FROM employee))*100 DESC
--
--112. 10�� �μ� �������� �����ϴ� ����ȣ, ����, ������ȣ�� �˻��ϸ�?
SELECT cus_no, cus_name, emp_no
FROM customer
WHERE emp_no = ANY(SELECT emp_no FROM employee WHERE dep_no = 10)

SELECT c.cus_no, c.cus_name, c.emp_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no AND e.dep_no = 10

SELECT cus_no, cus_name, emp_no
FROM customer c
WHERE 10 = (SELECT e.dep_no FROM employee e WHERE e.emp_no = c.emp_no AND e.dep_no = 10 )

--113. ��� ���� �̻��̰� �ִ� ���� �̸��� ������, ����, ��ü��տ���, ��ü�ִ뿬���� ����ϸ�?
SELECT emp_name, salary, (SELECT AVG(salary) FROM employee), (SELECT MAX(salary) FROM employee)
FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee) AND salary < (SELECT MAX(salary) FROM employee)

--114. �ְ� ���� ������ ������ȣ, ������, �μ���, ������ �˻��ϸ�?
SELECT emp_no, emp_name, (SELECT dep_name FROM dept d WHERE d.dep_no = e.dep_no), salary
FROM employee e
WHERE salary = (SELECT MAX(salary) FROM employee)

--115. ��� ���� 2�� �̻��� ������ȣ, ������, ������ �˻��ϸ�?
SELECT emp_no, emp_name, jikup
FROM employee e
WHERE 2 <= (SELECT COUNT(*) FROM customer c WHERE e.emp_no = c.emp_no)
--116. ������ȣ, ������, �ҼӺμ����� �˻��ϸ�?
SELECT emp_no, emp_name, (SELECT dep_name FROM dept d WHERE d.dep_no = e.dep_no)
FROM employee e

SELECT emp_no, emp_name, dep_name
FROM employee e, dept d
WHERE e.dep_no = d.dep_no

SELECT emp_no, emp_name, dep_name
FROM employee e INNER JOIN dept d ON e.dep_no = d.dep_no

--117. ������ȣ, ������, ����, ���� ������ ����ϸ�? ��, ���� ������ �������� ����
SELECT emp_no, emp_name, salary, (SELECT COUNT(*)+1 FROM employee e2 WHERE e1.salary < e2.salary)
FROM employee e1
ORDER BY 4
--118. ������ȣ, ������, �������� ����ϸ�?
SELECT emp_no, emp_name, (SELECT COUNT(*) FROM customer c WHERE c.emp_no = e.emp_no)
FROM employee e
--119. �μ���, �μ�������, �μ��������� ����ϸ�?
SELECT dep_name, (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no)
        , (SELECT COUNT(*) FROM employee e, customer c WHERE e.dep_no = d.dep_no AND e.emp_no = c.emp_no)
FROM dept d
--
--120. ������ȣ, ������, ����, �ֹι�ȣ, ���޼��������� ����ϸ�?
--��, ������ ������ ���� ���� ������ ���޼������� �̴�. �׸��� ���޼��������� �������� ����
SELECT emp_no, emp_name, jikup, jumin_num
    , (SELECT COUNT(*)+1 FROM employee e2
        WHERE DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
                > DECODE(e2.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
                OR (e1.jikup = e2.jikup AND DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 6)
                                    < DECODE(SUBSTR(e2.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e2.jumin_num, 1, 6)  )
        )    ���޼���
FROM employee e1
ORDER BY ���޼���
--
--121. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, �μ���ȣ�� ����ϸ�?
--<����> ��������� ���� ���� ����. ��, ������ ������� ���� ���������� ����Ͻʽÿ�.
SELECT cus_no, cus_name, tel_num, (SELECT emp_name FROM employee e WHERE e.emp_no = c.emp_no)
        , (SELECT jikup FROM employee e WHERE e.emp_no = c.emp_no)
        , (SELECT dep_no FROM employee e WHERE e.emp_no = c.emp_no)
FROM customer c
--
--122. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, �μ���ȣ�� ����ϸ�?
--<����>�������� ��� ���̰� ���������� 10�� �μ��� ���� ��. ��, ������ ������� ���� ���������� ����Ͻʽÿ�.
SELECT cus_no, cus_name, tel_num
        , (SELECT emp_name FROM employee e WHERE e.emp_no = c.emp_no AND e.dep_no = 10)
        , (SELECT jikup FROM employee e WHERE e.emp_no = c.emp_no AND e.dep_no = 10)
        , (SELECT dep_no FROM employee e WHERE e.emp_no = c.emp_no AND e.dep_no = 10)
FROM customer c

SELECT cus_no, cus_name, tel_num, emp_name, jikup, dep_no
FROM customer c, employee e
WHERE c.emp_no = e.emp_no(+) AND e.dep_no(+) = 10

SELECT cus_no, cus_name, tel_num, emp_name, jikup, dep_no
FROM customer c LEFT OUTER JOIN employee e ON c.emp_no = e.emp_no AND e.dep_no = 10
--
--124. �μ����� �μ���ȣ, �޿���, ��ձ޿�, �ο����� ����ϸ�? ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
SELECT dep_no, SUM(salary), ROUND(AVG(salary), 1), COUNT(*)
FROM employee
GROUP BY dep_no
--125. ���޺��� ����, �޿���, ��ձ޿�, �ο����� ����ϸ�? ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
SELECT jikup, SUM(salary), ROUND(AVG(salary), 1), COUNT(*)
FROM employee
GROUP BY jikup
--126. �μ���, ���޺�, �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϸ�? ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
SELECT dep_no, jikup, SUM(salary), ROUND(AVG(salary), 1), COUNT(*)
FROM employee
GROUP BY dep_no, jikup
--127. �μ���, ���޺�, �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϵ� �ο����� 3�� �̻��� ����ϸ�?
SELECT dep_no, jikup, SUM(salary), ROUND(AVG(salary), 1), COUNT(*)
FROM employee
GROUP BY dep_no, jikup
HAVING COUNT(*) >= 3
--128. �μ���, ������ �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϸ�?
SELECT dep_no, CASE WHEN SUBSTR(jumin_num, 7, 1) IN('1', '3') THEN '��' ELSE '��' END
        , SUM(salary), AVG(salary), COUNT(*)
FROM employee
GROUP BY dep_no, CASE WHEN SUBSTR(jumin_num, 7, 1)  IN('1', '3') THEN '��' ELSE '��' END
--129. �Ի�⵵���� �Ի�⵵, �ο����� ����ϰ� �⵵���� �������� �ϸ�?
SELECT EXTRACT(YEAR FROM hire_date), COUNT(*)
FROM employee
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY 1;
--130. �μ����� �μ���ȣ, ��ձٹ������ ����ϸ�? (�ٳ���� �Ҽ��� ��° �ڸ����� �ݿø��� ��)
SELECT dep_no, ROUND(AVG(EXTRACT(YEAR FROM hire_date)), 1)
FROM employee
GROUP BY dep_no
--131. �Ի�б⺰�� �Ի�б�, �ο����� ����ϸ�?
SELECT TO_CHAR(hire_date, 'Q'), COUNT(*)
FROM employee
GROUP BY TO_CHAR(hire_date, 'Q')
--132. �Ի翬�뺰, ������ �Ի翬��, ����, ���뺰�Ի��ڼ� ����ϸ�?
SELECT SUBSTR(TO_CHAR(hire_date, 'yyyy'), 1, 3)||'0��', CASE WHEN SUBSTR(jumin_num, 7, 1) IN('1', '3') THEN '��' ELSE '��' END
        , COUNT(*)
FROM employee
GROUP BY SUBSTR(TO_CHAR(hire_date, 'yyyy'), 1, 3)||'0��', CASE WHEN SUBSTR(jumin_num, 7, 1) IN('1', '3') THEN '��' ELSE '��' END
--
--133. ������, �Ի���(��-��-�� ~/4�б� �ѱ� 1�ڸ� ����), ������(��-��-��) ����ϸ�?
--<����> �������� �Ի� �� 20�� 5���� 10�� ��
SELECT emp_name, TO_CHAR(hire_date, 'YYYY-MM-DD Q/"4�б�" DY', 'NLS_DATE_LANGUAGE = KOREAN')
        , TO_CHAR(ADD_MONTHS(hire_date, 5+20*12)+10, 'YYYY-MM-DD' )
FROM employee

--
--134. �������� �ִ� �μ����� �μ���ȣ, �μ���ġ, �������� ����ϸ�? ��� �μ� �� ���Ͷ�
SELECT d.dep_no, d.loc, COUNT(e.emp_no)
FROM dept d, employee e
WHERE d.dep_no(+) = e.dep_no
GROUP BY d.dep_no, d.loc

SELECT d.dep_no, d.loc, COUNT(e.emp_no)
FROM dept d RIGHT OUTER JOIN employee e ON d.dep_no = e.dep_no
GROUP BY d.dep_no, d.loc

SELECT dep_no, loc, (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no)
FROM dept d

--
--135. ������ �Ի��, �ο����� �˻��ϸ�? �Ի�� �������� ���� <����> �Ի�� �������� ����
--<����> �� ������� 2��, 9���� ��� ������. 2��, 9���� ���Խ�Ű�� �ο����� 0���� �����Ϸ���?
SELECT EXTRACT(MONTH FROM hire_date), COUNT(*)
FROM employee e
GROUP BY EXTRACT(MONTH FROM hire_date)
ORDER BY 1
--
--136. employee ���̺��� ���޼������ �����Ͽ� ���޺��� ����, ������տ���, �ο����� �˻��ϸ�? (���� ������ ���� ���;���)
SELECT jikup, ROUND(AVG(salary), 1), COUNT(*)
FROM employee
GROUP BY jikup
ORDER BY DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
--137. �μ��� �μ���ȣ, �μ���, ������, �����̰����ϴ°����� �˻��ϸ�?
SELECT d.dep_no, d.dep_name, COUNT(DISTINCT e.emp_no), COUNT(c.emp_no)
FROM dept d, employee e, customer c
WHERE d.dep_no = e.dep_no(+) AND e.emp_no = c.emp_no(+)
GROUP BY d.dep_no, d.dep_name

SELECT d.dep_no, d.dep_name, COUNT(DISTINCT e.emp_no), COUNT(c.emp_no)
FROM dept d LEFT OUTER JOIN employee e ON d.dep_no = e.dep_no
            LEFT OUTER JOIN customer c ON e.emp_no = c.emp_no
GROUP BY d.dep_no, d.dep_name

SELECT dep_no, dep_name, (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no)
        , (SELECT COUNT(*) FROM customer c, employee e WHERE e.dep_no = d.dep_no AND c.emp_no = e.emp_no)
FROM dept d
--
--138. �������� 60����� ���� �Ͽ� �Ʒ�ó�� ����ϸ�?
--������ȣ, ������, �ٹ�����, �����ϱ��� ���� �⵵, ����(��-��-�� ���ϸ�), �ҼӺμ���, ���ӻ����, ���ӻ�� �μ���.
--��, ��� ���� �� ������, ���� ���� ����� ���� ������ ������ ������ ���̰� ���� ����� ���;���.
SELECT e1.emp_no, e1.emp_name, CEIL((SYSDATE - e1.hire_date)/365)
        , 60 - (EXTRACT(YEAR FROM SYSDATE)
                - TO_NUMBER(DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 2))
                + 1)
        , TO_CHAR(TO_DATE(CASE WHEN SUBSTR(e1.jumin_num, 7, 1) IN('1', '2') THEN '19' ELSE '20' END || SUBSTR(e1.jumin_num, 1, 6), 'YYYYMMDD')
                , 'YYYY-MM-DD DY', 'NLS_DATE_LANGUAGE = KOREAN ')
        , d1.dep_name
        , e2.emp_name
        , d2.dep_name
FROM employee e1, dept d1, employee e2, dept d2
WHERE e1.dep_no = d1.dep_no(+) AND e1.mgr_emp_no = e2.emp_no(+) AND e2.dep_no = d2.dep_no(+)
ORDER BY DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5), 5
--
SELECT e1.emp_no, e1.emp_name, CEIL((SYSDATE - e1.hire_date)/365)
        , 60 - (EXTRACT(YEAR FROM SYSDATE)
                - TO_NUMBER(DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 2))
                + 1)
        , TO_CHAR(TO_DATE(CASE WHEN SUBSTR(e1.jumin_num, 7, 1) IN('1', '2') THEN '19' ELSE '20' END || SUBSTR(e1.jumin_num, 1, 6), 'YYYYMMDD')
                , 'YYYY-MM-DD DY', 'NLS_DATE_LANGUAGE = KOREAN ')
        , d1.dep_name
        , e2.emp_name
        , d2.dep_name
FROM employee e1 LEFT OUTER JOIN dept d1 ON e1.dep_no = d1.dep_no
                 LEFT OUTER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
                 LEFT OUTER JOIN dept d2 ON e2.dep_no = d2.dep_no
ORDER BY DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5), 5

--
