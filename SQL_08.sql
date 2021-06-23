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
        , COUNT(*)              �ο���
FROM
        employee
GROUP BY
        dep_no, DECODE(SUBSTR(jumin_num, 7, 1), '1', '��', '3', '��', '��')
ORDER BY
        1;

-- 129. �Ի�⵵���� �Ի�⵵, �ο����� ����ϰ� �⵵���� �������� �ϸ�?
SELECT
        TO_CHAR(hire_date, 'YYYY')  �Ի�⵵
        , COUNT(*)                  �ο���
FROM
        employee
GROUP BY
        TO_CHAR(hire_date, 'YYYY')
ORDER BY
        1;