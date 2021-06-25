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
SELECT emp_no, jikup, salary, FLOOR((salary/(SELECT SUM(salary) FROM employee))*100)
FROM employee
ORDER BY (salary/(SELECT SUM(salary) FROM employee))*100 DESC
--
--112. 10�� �μ� �������� �����ϴ� ����ȣ, ����, ������ȣ�� �˻��ϸ�?
--113. ��� ���� �̻��̰� �ִ� ���� �̸��� ������, ����, ��ü��տ���, ��ü�ִ뿬���� ����ϸ�?
--114. �ְ� ���� ������ ������ȣ, ������, �μ���, ������ �˻��ϸ�?
--115. ��� ���� 2�� �̻��� ������ȣ, ������, ������ �˻��ϸ�?
--116. ������ȣ, ������, �ҼӺμ����� �˻��ϸ�?
--117. ������ȣ, ������, ����, ���� ������ ����ϸ�? ��, ���� ������ �������� ����
--118. ������ȣ, ������, �������� ����ϸ�?
--119. �μ���, �μ�������, �μ��������� ����ϸ�?
--
--120. ������ȣ, ������, ����, �ֹι�ȣ, ���޼��������� ����ϸ�?
--��, ������ ������ ���� ���� ������ ���޼������� �̴�. �׸��� ���޼��������� �������� ����
--
--121. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, �μ���ȣ�� ����ϸ�?
--<����> ��������� ���� ���� ����. ��, ������ ������� ���� ���������� ����Ͻʽÿ�.
--
--122. ����ȣ, ����, ����ȭ��ȣ, ���������, �����������, �μ���ȣ�� ����ϸ�?
--<����>�������� ��� ���̰� ���������� 10�� �μ��� ���� ��. ��, ������ ������� ���� ���������� ����Ͻʽÿ�.
--
--124. �μ����� �μ���ȣ, �޿���, ��ձ޿�, �ο����� ����ϸ�? ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
--125. ���޺��� ����, �޿���, ��ձ޿�, �ο����� ����ϸ�? ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
--126. �μ���, ���޺�, �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϸ�? ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
--127. �μ���, ���޺�, �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϵ� �ο����� 3�� �̻��� ����ϸ�?
--128. �μ���, ������ �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϸ�?
--129. �Ի�⵵���� �Ի�⵵, �ο����� ����ϰ� �⵵���� �������� �ϸ�?
--130. �μ����� �μ���ȣ, ��ձٹ������ ����ϸ�? (�ٳ���� �Ҽ��� ��° �ڸ����� �ݿø��� ��)
--131. �Ի�б⺰�� �Ի�б�, �ο����� ����ϸ�?
--132. �Ի翬�뺰, ������ �Ի翬��, ����, ���뺰�Ի��ڼ� ����ϸ�?
--
--133. ������, �Ի���(��-��-�� ~/4�б� �ѱ� 1�ڸ� ����), ������(��-��-��) ����ϸ�?
--<����> �������� �Ի� �� 20�� 5���� 10�� ��
--
--134. �������� �ִ� �μ����� �μ���ȣ, �μ���ġ, �������� ����ϸ�? ��� �μ� �� ���Ͷ�
--
--135. ������ �Ի��, �ο����� �˻��ϸ�? �Ի�� �������� ���� <����> �Ի�� �������� ����
--<����> �� ������� 2��, 9���� ��� ������. 2��, 9���� ���Խ�Ű�� �ο����� 0���� �����Ϸ���?
--
--136. employee ���̺��� ���޼������ �����Ͽ� ���޺��� ����, ������տ���, �ο����� �˻��ϸ�? (���� ������ ���� ���;���)
--137. �μ��� �μ���ȣ, �μ���, ������, �����̰����ϴ°����� �˻��ϸ�?
--
--138. �������� 60����� ���� �Ͽ� �Ʒ�ó�� ����ϸ�?
--������ȣ, ������, �ٹ�����, �����ϱ��� ���� �⵵, ����(��-��-�� ���ϸ�), �ҼӺμ���, ���ӻ����, ���ӻ�� �μ���.
--��, ��� ���� �� ������, ���� ���� ����� ���� ������ ������ ������ ���̰� ���� ����� ���;���.
--
--