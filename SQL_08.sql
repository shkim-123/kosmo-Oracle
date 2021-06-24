-- 124. �μ����� �μ���ȣ, �޿���, ��ձ޿�, �ο����� ����ϸ�?
-- ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
SELECT
        dep_no                  �μ���ȣ
        , SUM(salary)           �޿���
        , ROUND(AVG(salary), 1) ��ձ޿�
        , COUNT(*)||'��'        �ο���
FROM
        employee
GROUP BY
        dep_no;

-- 125. ���޺��� ����, �޿���, ��ձ޿�, �ο����� ����ϸ�?
-- ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
SELECT
        jikup                   ����
        , SUM(salary)           �޿���
        , ROUND(AVG(salary), 1) ��ձ޿�
        , COUNT(*)||'��'        �ο���
FROM
        employee
GROUP BY
        jikup;

-- 126. �μ���, ���޺�, �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϸ�?
-- ��, ����� �Ҽ� ��° �ڸ����� �ݿø� �� ��
SELECT
        dep_no                 �μ���ȣ
        , jikup                ����
        , SUM(salary)          �޿���
        , ROUND(AVG(salary),1) ��ձ޿�
        , COUNT(*)||'��'       �ο���
FROM
        employee
GROUP BY
        dep_no, jikup
ORDER BY
        1;

-- 127. �μ���, ���޺�, �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϵ�
-- �ο����� 3�� �̻��� ����ϸ�?
SELECT
        dep_no                 �μ���ȣ
        , jikup                ����
        , SUM(salary)          �޿���
        , ROUND(AVG(salary),1) ��ձ޿�
        , COUNT(*)||'��'       �ο���
FROM
        employee
GROUP BY
        dep_no, jikup
HAVING
        COUNT(*) >= 3;

-- 128. �μ���, ������ �μ���ȣ, ����, �޿���, ��ձ޿�, �ο����� ����ϸ�?
SELECT
        dep_no                  �μ���ȣ
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '��', '3', '��', '��')  ����
        , SUM(salary)           �޿���
        , ROUND(AVG(salary), 1) ��ձ޿�
        , COUNT(*)||'��'        �ο���
FROM
        employee
GROUP BY
        dep_no, DECODE(SUBSTR(jumin_num, 7, 1), '1', '��', '3', '��', '��')
ORDER BY
        1;

-- CASE ��
SELECT
        dep_no                  �μ���ȣ
        , CASE
             WHEN SUBSTR(jumin_num, 7, 1) IN ('1', '3') THEN '��'
             ELSE '��'
          END ����
        , SUM(salary)           �޿���
        , ROUND(AVG(salary), 1) ��ձ޿�
        , COUNT(*)||'��'        �ο���
FROM
        employee
GROUP BY
        dep_no
        , CASE
             WHEN SUBSTR(jumin_num, 7, 1) IN ('1', '3') THEN '��'
             ELSE '��'
          END
ORDER BY
        1;

-- 129. �Ի�⵵���� �Ի�⵵, �ο����� ����ϰ� �⵵���� �������� �ϸ�?
SELECT
        TO_CHAR(hire_date, 'YYYY')  �Ի�⵵
        , COUNT(*)||'��'            �ο���
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'YYYY')
ORDER BY
        1;

-- 130. �μ����� �μ���ȣ, ��ձٹ������ ����ϸ�?
-- (�ٳ���� �Ҽ��� ��° �ڸ����� �ݿø��� ��)
SELECT
        dep_no      �μ���ȣ
        , ROUND(
                AVG((SYSDATE - hire_date)/365), 1
        ) ��ձٹ����
FROM
        employee
GROUP BY
        dep_no;

-- 131. �Ի�б⺰�� �Ի�б�, �ο����� ����ϸ�?
SELECT
        TO_CHAR(hire_date, 'Q')||'�б�' �Ի�б�
        , COUNT(*)                      �ο���
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'Q');

-- 132. �Ի翬�뺰, ������ �Ի翬��, ����, ���뺰�Ի��ڼ� ����ϸ�?
SELECT
        FLOOR(TO_NUMBER(TO_CHAR(hire_date, 'YYYY'))*0.1)||'0���'      �Ի翬��
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '��', '3', '��', '��')  ����
        , COUNT(*)       ���뺰�Ի��ڼ�
FROM
        employee
GROUP BY
        FLOOR(TO_NUMBER(TO_CHAR(hire_date, 'YYYY'))*0.1)||'0���'
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '��', '3', '��', '��');

-- 133. ������, �Ի���(��-��-�� ~/4�б� �ѱ� 1�ڸ� ����), ������(��-��-��) ����ϸ�?
-- <����> �������� �Ի� �� 20�� 5���� 10�� ��
SELECT
        emp_name        ������
        , TO_CHAR(hire_date, 'YYYY-MM-DD Q/"4�б�" DY', 'NLS_DATE_LANGUAGE = Korean')  �Ի���
        , TO_CHAR(ADD_MONTHS(hire_date+10, 5) + 20*365, 'YYYY-MM-DD')   ������
FROM
        employee;

-- 134. �������� �ִ� �μ����� �μ���ȣ, �μ���ġ, �������� ����ϸ�? ��� �μ� �� ���Ͷ�
-- ORACLE JOIN
SELECT
        d.dep_no    �μ���ȣ
        , d.loc     �μ���ġ
        , COUNT(e.emp_no) ������
FROM
        dept d, employee e
WHERE
        e.dep_no = d.dep_no(+)
GROUP BY
        d.dep_no, d.loc
ORDER BY
        1;

-- ANSI JOIN
SELECT
        d.dep_no    �μ���ȣ
        , d.loc     �μ���ġ
        , COUNT(e.emp_no) ������
FROM
        dept d RIGHT OUTER JOIN employee e ON e.dep_no = d.dep_no
GROUP BY
        d.dep_no, d.loc
ORDER BY
        1;

-- SUBQUERY
SELECT
        d.dep_no    �μ���ȣ
        , d.loc     �μ���ġ
        , (SELECT COUNT(*) FROM employee e WHERE e.dep_no = d.dep_no )������
FROM
        dept d
ORDER BY
        1;

-- 135. ������ �Ի��, �ο����� �˻��ϸ�? �Ի�� �������� ����
-- <����> �� ������� 2��, 9���� ��� ������.
-- 2��, 9���� ���Խ�Ű�� �ο����� 0���� �����Ϸ���?
SELECT
        TO_CHAR(hire_date, 'MM') �Ի��
        ,COUNT(*)                �ο���
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'MM')
UNION ALL
SELECT
        '02'
        , 0
FROM
        DUAL
UNION ALL
SELECT
        '09'
        , 0
FROM
        DUAL
ORDER BY
        1;

-- 136. employee ���̺��� ���޼������ �����Ͽ� ���޺��� ����, ������տ���, �ο����� �˻��ϸ�?
-- (���� ������ ���� ���;���)
SELECT
        jikup           ����
        , ROUND(AVG(salary),1)   ������տ���
        , COUNT(*)      �ο���
FROM
        employee
GROUP BY
        jikup
HAVING
        COUNT(*) >= 5
-- �ο����� 5 �̻��� �÷��� ���� ���� ���
ORDER BY
    --  DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5);
        DECODE("����", '����', 1, '����', 2, '����', 3, '�븮', 4, 5);
-- ORDER BY ���� �����÷�, ������ȣ, �˸��ƽ��� �� �� �ִ�.

-- 137. �μ��� �μ���ȣ, �μ���, ������, �����̰����ϴ°����� �˻��ϸ�?
-- SUBQUERY
SELECT
        dep_no         �μ���ȣ
        , dep_name     �μ���
        , (SELECT COUNT(*) FROM employee e WHERE d.dep_no = e.dep_no) ������
        , (SELECT COUNT(*) FROM employee e, customer c WHERE d.dep_no = e.dep_no
                AND e.emp_no = c.emp_no) ��������
FROM
        dept d ;

-- ORACLE JOIN
SELECT
        d.dep_no           �μ���ȣ
       , d.dep_name        �μ���
       , COUNT(DISTINCT e.emp_no) ������
    -- , COUNT(e.emp_no)
    -- DISTINCT�� �� ���� �������� �ߺ��Ǽ� ���´�.
       , COUNT(c.cus_no)          ��������
    -- , COUNT(DISTINCT c.cus_no)
    -- DISTINCT�� ���� ���� ����ϴ� �������� �ȴ�.
FROM employee e, dept d, customer c
WHERE e.dep_no(+) = d.dep_no AND e.emp_no = c.emp_no(+)
GROUP BY d.dep_no
       , d.dep_name
ORDER BY 1;

-- ANSI JOIN
SELECT
        d.dep_no           �μ���ȣ
       , d.dep_name        �μ���
       , COUNT(DISTINCT e.emp_no) ������
       , COUNT(c.cus_no)          ��������
FROM employee e RIGHT OUTER JOIN dept d  ON  e.dep_no = d.dep_no
                LEFT OUTER JOIN customer c ON e.emp_no = c.emp_no
GROUP BY d.dep_no
       , d.dep_name
ORDER BY 1;


-- 138. �������� 60����� ���� �Ͽ� �Ʒ�ó�� ����ϸ�?
-- ������ȣ, ������, �ٹ�����, �����ϱ��� ���� �⵵, ����(��-��-�� ���ϸ�),
-- �ҼӺμ���, ���ӻ����, ���ӻ�� �μ���.
-- ��, ��� ���� �� ������, ���� ���� ����� ���� ������ ������ ������ ���̰� ���� ����� ���;���.
-- SUBQUERY
SELECT
        emp_no         ������ȣ
        , emp_name     ������
        , CEIL((SYSDATE - hire_date)/365)  �ٹ�����
        , 60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(
                DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                ||SUBSTR(jumin_num, 1, 2)) + 1 ) �����ϱ��������⵵
        , TO_CHAR(TO_DATE(DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')
                        ||SUBSTR(jumin_num, 1, 6), 'YYYYMMDD'), 'YYYY-MM-DD DY'
						, 'NLS_DATE_LANGUAGE = KOREAN') ����
        , (SELECT dep_name FROM dept d WHERE d.dep_no = e.dep_no)    �ҼӺμ���
        , (SELECT e2.emp_name FROM employee e2 WHERE e2.emp_no = e.mgr_emp_no)  ���ӻ����
        , (SELECT d.dep_name FROM employee e2, dept d
                        WHERE e2.emp_no = e.mgr_emp_no AND d.dep_no = e2.dep_no) ���ӻ���μ���
FROM
        employee e
ORDER BY
        DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
        , DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(jumin_num, 1, 6)

-- ORACLE JOIN
SELECT
        e1.emp_no       ������ȣ
        , e1.emp_name   ������
        , CEIL((SYSDATE - e1.hire_date)/365)  �ٹ�����
        , 60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(
                DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                ||SUBSTR(e1.jumin_num, 1, 2)) + 1 ) �����ϱ��������⵵
        , TO_CHAR(TO_DATE(DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                        ||SUBSTR(e1.jumin_num, 1, 6), 'YYYYMMDD'), 'YYYY-MM-DD DY'
						, 'NLS_DATE_LANGUAGE = KOREAN') ����
        , d1.dep_name   �ҼӺμ���
        , e2.emp_name   ���ӻ����
        , d2.dep_name   ���ӻ���μ���
FROM employee e1, dept d1, employee e2, dept d2
WHERE e1.dep_no = d1.dep_no(+) AND e1.mgr_emp_no = e2.emp_no(+) AND e2.dep_no = d2.dep_no(+)
ORDER BY DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
        , DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 6)

-- ANSI JOIN
SELECT
        e1.emp_no       ������ȣ
        , e1.emp_name   ������
        , CEIL((SYSDATE - e1.hire_date)/365)  �ٹ�����
        , 60 - (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(
                DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                                ||SUBSTR(e1.jumin_num, 1, 2)) + 1 ) �����ϱ��������⵵
        , TO_CHAR(TO_DATE(DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')
                        ||SUBSTR(e1.jumin_num, 1, 6), 'YYYYMMDD'), 'YYYY-MM-DD DY'
						, 'NLS_DATE_LANGUAGE = KOREAN') ����
        , d1.dep_name   �ҼӺμ���
        , e2.emp_name   ���ӻ����
        , d2.dep_name   ���ӻ���μ���
FROM employee e1 LEFT OUTER JOIN dept d1 ON e1.dep_no = d1.dep_no
                 LEFT OUTER JOIN employee e2 ON e1.mgr_emp_no = e2.emp_no
                 LEFT OUTER JOIN dept d2 ON e2.dep_no = d2.dep_no
ORDER BY DECODE(e1.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
        , DECODE(SUBSTR(e1.jumin_num, 7, 1), '1', '19', '2', '19', '20')||SUBSTR(e1.jumin_num, 1, 6)
